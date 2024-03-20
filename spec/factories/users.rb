FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    birthday { Faker::Date.birthday }
  end
end
