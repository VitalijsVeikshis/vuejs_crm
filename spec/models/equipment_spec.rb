require 'rails_helper'

RSpec.describe Equipment, type: :model do
  describe 'Associations' do
    it { should belong_to :organization }
  end
end
