FactoryBot.define do
  factory :good_found do
    execution_date {Faker::Date.between(from: 1.year.ago, to: Date.current)}
    title {Faker::Lorem.sentence}
    event_detail {Faker::Lorem.sentence}
    category_id {2}
    association :user
  end
end
