FactoryBot.define do
  factory :survey do
    name { Faker::Book.title }
    question_id { Faker::Internet.uuid }
  end
end
