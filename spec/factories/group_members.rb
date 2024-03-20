FactoryBot.define do
  factory :group_member do
    group_id { Faker::Internet.uuid }
    member_id { Faker::Internet.uuid }
    member_type { "User" }
  end
end
