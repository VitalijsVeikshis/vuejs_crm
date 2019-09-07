# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    sequence(:email) { |n| "client#{n}@test.com" }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
