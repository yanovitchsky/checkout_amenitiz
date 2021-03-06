require 'rails_helper'

RSpec.describe CashRegister::Repositories::Basket do
  describe "#set_item" do
    let(:products) {FactoryBot.create_list(:product, 3)}
    let(:repo) {described_class.new}
    context 'when basket or item does not exist' do
      it 'adds item to basket' do
        basket = FactoryBot.create(:basket)
        expect { 
          repo.set_item(SecureRandom.uuid, products.first.id, 1)
        }.to raise_error(::Repositories::RecordNotFoundError)
        expect { 
          repo.set_item(basket.id, SecureRandom.uuid, 1)
        }.to raise_error(::Repositories::RecordNotFoundError)
      end
    end

    context 'when item is not in basket' do
      it 'adds item to basket' do
        basket = FactoryBot.create(:basket)
        product = products.first
        basket_result = repo.set_item(basket.id, product.code,1)
        expect(basket_result).to include(items: {product.code => {price: product.price, quantity: 1, name: product.name}})
      end
    end

    context 'when item is in basket' do
      it 'increase item quantity' do
        basket = FactoryBot.create(:basket)
        product = products.first
        basket.line_items.create(quantity: 1, product: product)
        basket_result = repo.set_item(basket.id, product.code,3)
        expect(basket_result).to include(items: {product.code => {price: product.price, quantity: 4, name: product.name}})
      end

      it 'decrease item quantity' do
        basket = FactoryBot.create(:basket)
        product = products.first
        basket.line_items.create(quantity: 2, product: product)
        basket_result = repo.set_item(basket.id, product.code,-1)
        expect(basket_result).to include(items: {product.code => {price: product.price, quantity: 1, name: product.name}})
      end
    end

    context 'when quantity is 0 or less' do
      it 'removes line items' do
        basket = FactoryBot.create(:basket)
        product = products.first
        basket.line_items.create(quantity: 4, product: product)
        basket_result = repo.set_item(basket.id, product.code, -4)
        expect(basket_result).to include(items: {})
      end
    end
  end
end