# frozen_string_literal: true

FactoryBot.define do
  factory :organization do
    sequence(:name) { |n| "organization_name_#{n}" }
    form_of_ownership { 'ООО' }
    sequence(:inn) { |n| (1_000_000_000 + n).to_s }
    sequence(:ogrn) { |n| (1_000_000_000_000 + n).to_s }
  end

  trait :ip do
    form_of_ownership { 'ИП' }
    sequence(:inn) { |n| (1_000_000_000_00 + n).to_s }
  end

  trait :invalid do
    name { nil }
    form_of_ownership { nil }
    inn { nil }
    ogrn { nil }
  end
end
