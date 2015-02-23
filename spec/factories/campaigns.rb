FactoryGirl.define do
  factory :campaign do

    association :user, factory: :user # if no user associated, then create a user for factory

#    title Faker::Company.bs, but to get unique titles, we use a sequence
    sequence(:title) { |n| "#{Faker::Company.bs}-#{n}"}

    description Faker::Lorem.paragraph
    goal 1000
    aasm_state "published"
    due_date "2019-05-05 10:33:20"
    after(:build) { |c| c.reward_levels << FactoryGirl.create(:reward_level) }
  end

end