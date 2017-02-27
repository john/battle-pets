# {'name': 'Doug', 'strength': 12, 'intelligence': 22, 'speed': 21, 'integrity': 66}

@heds = {content_type: :json, accept: :json}
@wunder_api = Rails.application.secrets.pets_api_url

###### METHODS

def create_pet
  puts "\nEnter the deets for you new pet in this format, with single quotes: {'name': 'Leonard', 'strength': 12, 'intelligence': 22, 'speed': 21, 'integrity': 66}"
  payload = STDIN.gets.strip
  hed = {content_type: :json, accept: :json, "X-Pets-Token": Rails.application.secrets.pets_token}
  resp = RestClient.post("#{@wunder_api}/pets", payload.gsub("'", '"'), hed )
  if resp.code == 201
    pet = Pet.create(JSON.parse(resp.body))
    @player1 = pet.id.to_s
  end
  puts "\nOk, your new pet was added, player 1 is #{resp.body['name']}. Pick again."
end

def show_pets(create=false)
  resp = RestClient.get("#{@api}/pets", @heds)
  if resp.code != 200
    puts "I'm sorry, I couldn't get the list of pets."
    exit
  end
  puts "\nYour options:"
  pets = JSON.parse(resp.body)["pets"]
  pets.each_with_index do |pet, i|
    puts "#{i+1}: #{pet["name"]}. strength #{pet["strength"]}, speed #{pet["speed"]}, smarts #{pet["intelligence"]}, integrity #{pet["integrity"]}"
  end
  puts "#{pets.size+1}: These all suck, let me create my own."

  puts "\nPick or create contestant #1:"
  @player1 = STDIN.gets.strip

  if @player1.to_i == (pets.size.to_i+1)
    create_pet
  end
end


###### RUN BATTLE

puts "\nWhat endpoint do you want to use? (1=local, 2=Heroku)"
endpoint = STDIN.gets.strip
if endpoint == "1"
  @api = "http://localhost:3000/api/v1"
elsif endpoint == "2"
  @api = "https://battle-pets.herokuapp.com/api/v1"
else
  puts "C'mon, be serious"
  exit
end

puts "\nThanks. Who and I speaking with?"
name = STDIN.gets.strip

puts "\nHi, #{name}. What's your email?"
email = STDIN.gets.strip

puts "\nDo you have an account? (y/n)"
has_account = STDIN.gets.strip

#############

# @api = "http://localhost:3000/api/v1"
# name = 'john'
# email = 'john@fnnny.com'
# has_account = 'y'

if has_account.starts_with?('y')
  puts "\nPassword?"
  password = STDIN.gets.strip
  payload = { user: {email: email, password: password } }
  begin
    resp = RestClient.post("#{@api}/users/sign_in", payload.to_json, @heds)
    token = JSON.parse(resp.body)["auth_token"]
  rescue
    puts "\nDidn't work, maybe wrong password? Start again."
    exit
  end
else
  puts "\nOk we'll create one. What do you want your password to be?"
  password = STDIN.gets.strip
  payload = { user: {name: name, email: email, password: password } }
  resp = RestClient.post("#{@api}/users", payload.to_json, @heds)

  payload = { user: {email: email, password: password } }
  resp = RestClient.post("#{@api}/users/sign_in", payload.to_json, @heds)
  token = JSON.parse(resp.body)["auth_token"]
end
@heds[:x_auth_token] = token

puts "\nOk you're all set. Ready to play a game? (y/n)"
ready = STDIN.gets.strip.downcase

if !ready.starts_with?('y')
  puts "\nFine, whatever."
  exit
end

# Pick Contest.
puts "\nAwesome. Here are the available contests (enter #):"
resp = RestClient.get("#{@api}/contests", @heds)
contests = JSON.parse(resp.body)["contests"]
contests.each_with_index do |contest, i|
  puts "#{i+1}: #{contest["name"]}"
end
contest_id = STDIN.gets.strip.downcase

# Pick Participants
puts "\nPick yer ponies! Getting a list of pets..."

############

show_pets

############

puts "\nPick contestant #2:"
player2 = STDIN.gets.strip

# Create Battle
payload = {battle: {contest_id: contest_id}}
# This needs to return the object, so it can be used to create the participants

resp = RestClient.post("#{@api}/battles", payload.to_json, @heds)
if resp.code == 200
  battle_id = JSON.parse(resp.body)["id"]
else
  puts "I'm sorry, something went wrong creating the battle"
  exit
end

# Create Participants
payload = {participant: {battle_id: battle_id, pet_id: @player1}}
resp = RestClient.post("#{@api}/participants", payload.to_json, @heds)

payload = {participant: {battle_id: battle_id, pet_id: player2}}
resp = RestClient.post("#{@api}/participants", payload.to_json, @heds)

puts "\nAlrighty, we're ready to rumble. Press 'b' to start the battle."

start = STDIN.gets.strip
if start != "b"
  puts "Wrong. You lose."
  exit
else
  payload = {battle: {id: battle_id, start_at: 'now'}}
  resp = RestClient.patch("#{@api}/battles/#{battle_id}", payload.to_json, @heds)
end

puts "\nThe battle is begun. And probably ended by now. Want to find out who won? (y/n)"
get_status = STDIN.gets.strip

unless get_status.starts_with?('y')
  puts "\nOk, it shall remain a mystery. Goodbye."
else
  resp = RestClient.get("#{@api}/battles/#{battle_id}", @heds)
  battle = JSON.parse(resp.body)
  winner = Pet.find(battle['won_by'])

  if battle['upset'].to_s == 'true'
    puts "UPSET! "
  end

  puts "\nWe have a winner! #{winner.name}!"
end
