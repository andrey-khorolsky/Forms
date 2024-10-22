FactoryBot.define do
  factory :answer do
    user_id { Faker::Internet.uuid }
    survey_id { Faker::Internet.uuid }
    answer_mongo_id { Faker::Lorem.characters(number: 24) }

    trait :with_answer_data do
      after(:create) do |answer|
        answer_data = create(:answer_datum)
        answer.update(answer_mongo_id: answer_data.id.to_s)
      end
    end
  end
end
