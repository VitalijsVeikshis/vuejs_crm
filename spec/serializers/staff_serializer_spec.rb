# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaffSerializer, type: :serializer do
  staff_attributes = %i[id email]

  context 'when receives single staff' do
    let!(:staff) { create(:staff) }
    let(:serialized) { StaffSerializer.new(Staff.first).serializable_hash }

    staff_attributes.each do |attr|
      it "serialize staff with #{attr}" do
        expect(serialized.dig(:data, :attributes, attr))
          .to eq staff.as_json.dig(attr.to_s)
      end
    end
  end
end