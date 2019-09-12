# frozen_string_literal: true

FactoryBot.define do
  factory :staff do
    sequence(:email) { |n| "staff#{n}@test.com" }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
