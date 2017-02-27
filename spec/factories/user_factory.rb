FactoryGirl.define do

  factory :user do
    name "Abe Vigoda"
    sequence(:email) { |n| "abe_#{n}@example.com" }
    sequence(:password) { |n| "abcd123#{n}" }
    authentication_token "abc123"
  end

end