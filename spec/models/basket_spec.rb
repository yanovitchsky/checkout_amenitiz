require 'rails_helper'

RSpec.describe Basket, type: :model do
  describe 'associations' do
    it { should have_many(:line_items) }
    it { should have_many(:products).through(:line_items) }
  end
end
