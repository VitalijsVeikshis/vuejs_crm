# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :fullname }
    it { should validate_length_of(:fullname).is_at_least(5) }
    it { should validate_presence_of :phone }
    it { should validate_numericality_of(:phone).only_integer }
    it { should allow_value('test@mail.com').for(:email) }
    it { should_not allow_values('test', 'test@mail').for(:email) }

    describe 'phone uniqueness' do
      subject { create(:client) }
      it { should validate_uniqueness_of(:phone).case_insensitive }
    end
  end

  describe 'Callbacks' do
    let!(:client) { build(:client) }

    it 'sets password for new client' do
      expect { client.save }.to change { client.encrypted_password }
    end
  end
end
