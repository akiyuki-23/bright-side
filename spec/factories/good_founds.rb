FactoryBot.define do
  factory :good_found do
    execution_date {2023/01/01}
    title {Faker::Lorem.sentence}
    event_detail {Faker::Lorem.sentence}
    category_id {2}
    association :user
  end
end
