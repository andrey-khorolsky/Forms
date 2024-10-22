FactoryBot.define do
  factory :question do
    questions_count { 2 }
    questions do
      [
        {
          id: "1",
          number: 1,
          type: "text",
          text: Faker::Lorem.question
        },
        {
          id: "2",
          number: 2,
          type: "checkbox",
          text: Faker::Lorem.question
        }
      ]
    end
  end
end
