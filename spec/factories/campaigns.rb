FactoryGirl.define do
  factory :campaign do
#    title Faker::Company.bs, but to get unique titles, we use a sequence
    sequence(:title) { |n| "#{Faker::Company.bs}-#{n}"}

    description Faker::Lorem.paragraph
    goal 1000
    due_date "2019-05-05 10:33:20"
  end

end