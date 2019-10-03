# frozen_string_literal: true

FactoryBot.define do
  factory :equipment do
    sequence(:title) { |n| "equipment_title_#{n}" }
    sequence(:kind) { |n| "equipment_kind_#{n}" }
    sequence(:sn) { |n| "equipment_sn_#{n}" }
  end
end
