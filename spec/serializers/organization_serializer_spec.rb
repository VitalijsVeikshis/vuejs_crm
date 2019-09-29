# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationSerializer, type: :serializer do
  organization_attributes = %i[id name form_of_ownership inn ogrn]

  context 'when receives single organization' do
    let!(:organization) { create(:organization) }
    let(:serialized) { OrganizationSerializer.new(Organization.first).serializable_hash }

    organization_attributes.each do |attr|
      it "serialize organization with #{attr}" do
        expect(serialized.dig(:data, :attributes, attr))
          .to eq organization.as_json.dig(attr.to_s)
      end
    end
  end

  context 'when receives list of organizations' do
    let!(:organization) { create_list(:organization, 3) }
    let(:serialized) { OrganizationSerializer.new(Organization.all).serializable_hash }

    it 'serialize list of organizations' do
      expect(serialized.dig(:data).size).to eq organization.count
    end
  end
end
