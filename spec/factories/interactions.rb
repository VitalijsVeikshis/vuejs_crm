# frozen_string_literal: true

FactoryBot.define do
  factory :interaction do
    client_id { create(:client).id }
    organization_id { create(:organization).id }

    trait :invalid do
      client_id { nil }
      organization_id { nil }
    end
  end
end
