require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:basket) }
  end
end
