FactoryBot.define do
  factory :answer_datum do
    answers_count { 2 }
    answer_data {
      [
        {
          number: 1,
          result: Faker::Lorem.sentence(word_count: 3)
        },
        {
          number: 2,
          result: Faker::Lorem.sentence(word_count: 4)
        }
      ]
    }
  end
end
