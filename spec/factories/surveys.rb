FactoryBot.define do
  factory :survey do
    name { Faker::Book.title }
    question_mongo_id { Faker::Internet.uuid }
  end
end
