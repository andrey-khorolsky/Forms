FactoryBot.define do
  factory :answer do
    user_id { Faker::Internet.uuid }
    survey_id { Faker::Internet.uuid }
    answer_id { Faker::Lorem.characters(number: 24) }
  end
end
