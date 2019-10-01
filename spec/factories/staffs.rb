# frozen_string_literal: true

FactoryBot.define do
  factory :staff do
    sequence(:email) { |n| "staff#{n}@test.com" }

    trait :invalid do
      email { nil }
    end
  end
end
