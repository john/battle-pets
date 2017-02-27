class FightBattleJob < ApplicationJob
  queue_as :default

  # TODO: This is a hot mess
  def perform( battle )
    battle.start_at = Time.now

    # randomly pick winner
    # battle.won_by = battle.participants.map{|p| p.id}.sample

    # slightly randomize to avoid ties and for the occasional upset
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

    # logger.debug "----------> sorted participants: #{sorted_by_score.inspect}"
    # logger.debug "===========> participants_array 0: #{participants_array[0]}"
    # logger.debug "===========> participants_array 1: #{participants_array[1]}"
    # logger.debug "===========> sorted_by_score 0: #{sorted_by_score[0]}"
    # logger.debug "===========> sorted_by_score 1: #{sorted_by_score[1]}"

    if (natural_winner.id.to_s == participants_array[0][:id]) || (participants[0].pet.send(characteristic).to_i == participants[1].pet.send(characteristic).to_i)
      #logger.debug "----------> natural winner won"
      battle.upset = false
    else
      #logger.debug "----------> upset!"
      battle.upset = true
    end

    battle.won_by = sorted_by_score[0][:id]
    battle.won_at = Time.now
    battle.save
  end
end
