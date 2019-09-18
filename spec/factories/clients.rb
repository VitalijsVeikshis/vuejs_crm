# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    sequence(:email) { |n| "client#{n}@test.com" }
    sequence(:fullname) { |n| "fullname_#{n}" }
    sequence(:phone) { |n| "123456#{n}" }

    trait :invalid do
      email { nil }
    end
  end
end
