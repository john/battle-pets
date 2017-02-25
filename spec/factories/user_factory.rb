FactoryGirl.define do

  factory :user do
    name "Abe Vigoda"
    sequence(:email) { |n| "abe_#{n}@example.com" }
    sequence(:password) { |n| "abcd123#{n}" }

    # factory :facebook_user do
    #   transient do
    #     fb_identity { create :facebook_identity }
    #   end
    #
    #   after(:create) do |facebook_user, evaluator|
    #     evaluator.fb_identity.user = facebook_user
    #   end
    # end
  end

end