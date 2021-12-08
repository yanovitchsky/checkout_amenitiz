require 'rails_helper'

require Rails.root.join('spec/support/fake_basket_repository.rb')

RSpec.describe CashRegister::Promotions::Rules::ItemDiscount do
  let(:product) { FactoryBot.build(:product) }
  let(:promotion) do
    FactoryBot.build(
      :promotion,
      conditions: {product_code: product.code, min_item: 2}.to_json,
      actions: [{type: 'adjust_price_amount', product_code: product.code, discount: '0.5'}].to_json
    )
  end
  let(:basket_id) { SecureRandom.uuid}

  describe '#eligible?' do
    context 'conditions not met' do
      it 'returns false' do
        basket = {product.code => {price: product.price, quantity: 1}}
        repository = FakeBasketRepository.new(basket)
        rule = described_class.new(repository, basket_id)
        conditions = JSON.parse(promotion.conditions)
        expect(rule.eligible?(conditions)).to be_falsy
      end
    end
    context 'conditions met' do
      it 'returns true' do
        basket = {product.code => {price: product.price, quantity: 4}}
        repository = FakeBasketRepository.new(basket)
        rule = described_class.new(repository, basket_id)
        conditions = JSON.parse(promotion.conditions)
        expect(rule.eligible?(conditions)).to be_truthy
      end
    end
  end

  describe "#apply" do
    context 'when is not eligible?' do
      let(:repository) { FakeBasketRepository.new({}) }
      fake(:adjust_price_amount) { CashRegister::Promotions::Actions::AdjustPriceAmount}
      it 'does not apply actions' do
        fake_class(CashRegister::Promotions::Actions::AdjustPriceAmount, new: adjust_price_amount)
        
        rule = described_class.new(repository, basket_id)
        stub(rule).eligible?(any_args) { false }
        stub(adjust_price_amount).apply(basket_id, 'abcd', '0.5')
        conditions = JSON.parse(promotion.conditions)
        actions = JSON.parse(promotion.actions)

        rule.apply(conditions, actions)

        expect(adjust_price_amount).not_to have_received.apply(basket_id, 'abcd', '0.5')
      end
    end

    context 'when is eligible?' do
      let(:repository) { FakeBasketRepository.new({product.code => {price: product.price, quantity: 4}}) }
      fake(:adjust_price_amount) { CashRegister::Promotions::Actions::AdjustPriceAmount}
      
      it 'applies actions' do
        fake_class(CashRegister::Promotions::Actions::AdjustPriceAmount, new: adjust_price_amount)
        
        rule = described_class.new(repository, basket_id)
        stub(rule).eligible?(any_args) { true }
        conditions = JSON.parse(promotion.conditions)
        actions = JSON.parse(promotion.actions)
        stub(adjust_price_amount).apply(basket_id, product.code, actions.first['discount']) { 12.5 }
        
        rule.apply(conditions, actions)
        expect(adjust_price_amount).to have_received.apply(basket_id, product.code, actions.first['discount'])
      end

      it 'return discount prices' do
        fake_class(CashRegister::Promotions::Actions::AdjustPriceAmount, new: adjust_price_amount)
        
        rule = described_class.new(repository, basket_id)
        stub(rule).eligible?(any_args) { true }
        conditions = JSON.parse(promotion.conditions)
        actions = JSON.parse(promotion.actions)
        stub(adjust_price_amount).apply(basket_id, product.code, actions.first['discount']) { 12.5 }
        
        res = rule.apply(conditions, actions)
        expect(res).to eq(12.5)
      end
    end
  end
end