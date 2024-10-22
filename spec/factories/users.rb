FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "123123" }
    name { Faker::Name.name }
    birthday { Faker::Date.birthday }
  end
end
