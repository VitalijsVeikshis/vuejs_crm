# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientSerializer, type: :serializer do
  client_attributes = %i[id fullname phone email]

  context 'when receives single client' do
    let!(:client) { create(:client) }
    let(:serialized) { ClientSerializer.new(Client.first).serializable_hash }

    client_attributes.each do |attr|
      it "serialize client with #{attr}" do
        expect(serialized.dig(:data, :attributes, attr))
          .to eq client.as_json.dig(attr.to_s)
      end
    end
  end

  context 'when receives list of clients' do
    let!(:clients) { create_list(:client, 3) }
    let(:serialized) { ClientSerializer.new(Client.all).serializable_hash }

    it 'serialize list of clients' do
      expect(serialized.dig(:data).size).to eq clients.count
    end
  end
end
