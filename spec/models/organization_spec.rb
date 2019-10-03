# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'Associations' do
    it { should have_many(:equipments).dependent(:destroy) }
    it { should have_many(:interactions) }
    it { should have_many(:clients).through(:interactions).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }

    it { should validate_presence_of :form_of_ownership }

    it { should validate_presence_of :inn }
    it { should validate_numericality_of(:inn).only_integer }

    it { should validate_presence_of :ogrn }
    it { should validate_length_of(:ogrn).is_equal_to(13) }
    it { should validate_numericality_of(:ogrn).only_integer }

    describe 'name uniqueness' do
      subject { create(:organization) }
      it { should validate_uniqueness_of(:name).case_insensitive }
    end

    describe 'inn uniqueness' do
      subject { create(:organization) }
      it { should validate_uniqueness_of(:inn).case_insensitive }
    end

    describe 'ogrn uniqueness' do
      subject { create(:organization) }
      it { should validate_uniqueness_of(:ogrn).case_insensitive }
    end
  end

  describe '.validate_inn_length' do
    context 'when organization form is IP with valid INN length' do
      subject { build(:organization, :ip) }

      it 'should validate that INN is 12 characters' do
        subject.valid?
        subject.errors[:inn].should_not include('Please use 12 characters')
      end
    end

    context 'when organization form is IP with invalid INN length' do
      subject { build(:organization, :ip, inn: '1') }

      it 'should validate that INN not is 12 characters' do
        subject.valid?
        subject.errors[:inn].should include('Please use 12 characters')
      end
    end

    context 'when other organization forms with valid INN length' do
      subject { build(:organization) }

      it 'should validate that INN is 10 characters' do
        subject.valid?
        subject.errors[:inn].should_not include('Please use 10 characters')
      end
    end

    context 'when other organization forms with invalid INN length' do
      subject { build(:organization, inn: '1') }

      it 'should validate that INN not is 10 characters' do
        subject.valid?
        subject.errors[:inn].should include('Please use 10 characters')
      end
    end
  end
end
