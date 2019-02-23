FactoryBot.define do
  factory :address, class: Address do
    association :user, factory: :order_item
    sequence(:address) { |n| "Address #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:state) { |n| "State #{n}" }
    sequence(:zip) { |n| "Zip #{n}" }
    nickname { 0 }
    active { true }
    default { true }
    shipped_to? { true }
  end

  factory :inactive_address, parent: :address do
    association :user, factory: :order_item
    sequence(:address) { |n| "Inactive Address #{n}" }
    active { false }
  end
  factory :not_shipped_to_address, parent: :address do
    association :user
    sequence(:address) { |n| "Never Shipped Address #{n}" }
    shipped_to? { false }
  end
  factory :default_address, parent: :address do
    association :user, factory: :order_item
    sequence(:address) { |n| "Default Address #{n}" }
    default { true }
  end
  factory :work_address, parent: :address do
    association :user, factory: :order_item
    sequence(:address) { |n| "Work Address #{n}" }
    nickname { 1 }
  end
end
