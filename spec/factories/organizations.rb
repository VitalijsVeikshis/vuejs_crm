# frozen_string_literal: true

FactoryBot.define do
  factory :organization do
    sequence(:name) { |n| "organization_name_#{n}" }
    form_of_ownership { :ooo }
    sequence(:inn) { |n| (1_000_000_000 + n).to_s }
    sequence(:ogrn) { |n| (1_000_000_000_000 + n).to_s }
  end

  trait :ip do
    form_of_ownership { :ip }
    sequence(:inn) { |n| (1_000_000_000_00 + n).to_s }
  end
end
