FactoryBot.define do
  factory :role do
    name { [Role::ADMIN, Role::MANAGER, Role::GUEST].sample }

    trait :guest do
      name { Role::GUEST }
    end

    trait :manager do
      name { Role::MANAGER }
    end

    trait :admin do
      name { Role::ADMIN }
    end
  end
end
