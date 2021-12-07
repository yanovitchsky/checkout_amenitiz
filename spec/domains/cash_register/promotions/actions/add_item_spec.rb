require 'rails_helper'

require Rails.root.join('spec/support/fake_basket_repository.rb')

RSpec.describe CashRegister::Promotions::Actions::AddItem do
  describe "#apply" do
    it 'adds item to basket' do
      basket_id = SecureRandom.uuid
      product_id = SecureRandom.uuid
      basket = {product_id => {price: 10, quantity: 2}}
      repository = FakeBasketRepository.new(basket)
      action = described_class.new(repository)
      result = action.apply(basket_id, product_id, 2)
      expect(basket).to eq({product_id => {price: 10, quantity: 4}})
      expect(result).to eq(0)
    end
  end
end