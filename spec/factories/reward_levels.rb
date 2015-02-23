FactoryGirl.define do
  factory :reward_level do
    sequence(:title) { |n| "#{Faker::Company.bs}-#{n}" }
    sequence(:amount) { |n| 100 + n }
    body "MyText"
    quantity 1000
  end

end