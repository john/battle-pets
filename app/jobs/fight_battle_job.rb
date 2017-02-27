class FightBattleJob < ApplicationJob
  queue_as :default

  def perform( battle )
    battle.start_at = Time.now

    # randomly pick winner
    # battle.won_by = battle.participants.map{|p| p.id}.sample

    # slightly randomize to avoid ties and for the occasional upset
    characteristic = battle.contest.winning_characteristic
    participants = battle.participants.to_a
    participants_array = participants.map do |p|
      val = p.pet.send(characteristic)
      {id: p.pet.id, name: p.pet.name, characteristic: characteristic, val: (val + rand(0..(val*0.2))) }
    end
    logger.debug "---------- part_array: #{participants_array.inspect}"

    # sort participants by value of that characteristic (key)
    sorted_by_score = participants_array.sort_by{|k| k['val']}.reverse!
    logger.debug "----------> sorted participants: #{sorted_by_score.inspect}"

    battle.won_by = sorted_by_score[0][:id]
    battle.won_at = Time.now
    battle.save
  end
end
