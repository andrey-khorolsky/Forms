FactoryBot.define do
  factory :permission do
    owner { create(:user) }
    entity { create(:survey) }
    role { create(:role) }

    trait :with_guest_role do
      role { create(:role, :guest) }
    end

    trait :with_manager_role do
      role { create(:role, :manager) }
    end

    trait :with_admin_role do
      role { create(:role, :admin) }
    end
  end
end
