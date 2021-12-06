require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject { Product.new(code: Faker::Alphanumeric.alpha(number: 3), name: Faker::Commerce.product_name, price: Faker::Commerce.price) }
    it { should validate_presence_of(:name) }
    
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }
    
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
  end
end
