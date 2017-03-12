FactoryGirl.define do

  factory :battle do
    after(:create) do |battle|
      battle.contest = FactoryGirl.create(:contest)
      battle.save
    end
  end

end