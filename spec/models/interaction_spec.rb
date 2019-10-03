# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction, type: :model do
  describe 'Associations' do
    it { should belong_to :client }
    it { should belong_to :organization }
  end
end
