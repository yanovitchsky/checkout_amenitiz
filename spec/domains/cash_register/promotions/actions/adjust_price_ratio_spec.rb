require 'rails_helper'

require Rails.root.join('spec/support/fake_basket_repository.rb')

RSpec.describe CashRegister::Promotions::Actions::AdjustPriceRatio do
  describe "#apply" do
    context 'when product is not in basket' do
      it 'returns 0' do
        repository = FakeBasketRepository.new({})
        action = described_class.new(repository)
        expect(action.apply(SecureRandom.uuid, "ABC", Rational('2/3'))).to eq(0)
      end
    end
    context 'when product is in basket' do
      it 'return amount' do
        basket_id = SecureRandom.uuid
        product = FactoryBot.build(:product)
        basket = {product.code => {price: 11.23, quantity: 3}}
        repository = FakeBasketRepository.new(basket)
        action = described_class.new(repository)
        expect(action.apply(basket_id, product.code, Rational('2/3'))).to eq(11.23)
      end
    end
  end
end