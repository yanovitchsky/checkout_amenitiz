require 'rails_helper'

require Rails.root.join('spec/support/fake_basket_repository.rb')

RSpec.describe CashRegister::Promotions::Actions::AdjustPriceAmount do
  describe "#apply" do
    context "when item is not in basket" do
      it 'returns 0' do
        repository = FakeBasketRepository.new({})
        action = described_class.new(repository)
        expect(action.apply(SecureRandom.uuid, "ABC", 5)).to eq(0)
      end
    end
    context "when item is in basket" do
      it 'return amount' do
        basket_id = SecureRandom.uuid
        product = FactoryBot.build(:product)
        basket = {product.code => {price: 10, quantity: 2}}
        repository = FakeBasketRepository.new(basket)
        action = described_class.new(repository)
        expect(action.apply(basket_id, product.code, 5)).to eq(10)
      end
    end
  end
end