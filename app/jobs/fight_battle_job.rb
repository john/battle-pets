class FightBattleJob < ApplicationJob
  queue_as :default

  # TODO: This is a hot mess
  def perform( battle )
    battle.start_at = Time.now

    # randomly pick winner
    # battle.won_by = battle.participants.map{|p| p.id}.sample

    # Randomize a little to avoid ties and for the occasional upset
    characteristic = battle.contest.winning_characteristic
    participants = battle.participants.to_a

    if participants[0].pet.send(characteristic).to_i > participants[1].pet.send(characteristic).to_i
      natural_winner = participants[0].pet
    else
      natural_winner = participants[1].pet
    end
    participants_array = participants.map do |p|
      val = p.pet.send(characteristic).to_i
      {id: p.pet.id, name: p.pet.name, characteristic: characteristic, val: (val + rand(0..(val*0.1))).to_f }
    end

    # sort participants by value of that characteristic (key)
    sorted_by_score = participants_array.sort_by{|p| p[:val].to_f}.reverse!

    # TODO: fix.
    # # the actual winner is different than the natural winner, original values aren't the same
    # if (natural_winner.id.to_i != participants_array[0][:id].to_i) && (participants[0].pet.send(characteristic).to_i != participants[1].pet.send(characteristic).to_i)
    #   battle.upset = true
    # else
    #   battle.upset = false
    # end

    battle.won_by = sorted_by_score[0][:id]
    battle.won_at = Time.now
    battle.save
  end
end
