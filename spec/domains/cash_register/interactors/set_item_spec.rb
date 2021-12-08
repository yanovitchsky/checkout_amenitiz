require 'rails_helper'

require Rails.root.join('spec/support/fake_basket_repository.rb')

RSpec.describe CashRegister::Interactors::SetItem do
  describe '#call' do
    
    context 'when basket or item does not exist' do
      fake(:repository) {CashRegister::Repositories::Basket}
      it 'broadcast basket_or_item_not_found' do
        stub(repository).find(any_args) { raise Repositories::RecordNotFoundError }
        stub(repository).find_product(any_args) { raise Repositories::RecordNotFoundError }
        interactor = described_class.new(repository)
        expect { interactor.call(SecureRandom.uuid, SecureRandom.uuid, 1) }.to broadcast(:basket_or_product_not_found)
      end
    end
    context 'when item is not in basket' do
      it 'adds item' do
        repository = FakeBasketRepository.new()
        interactor = described_class.new(repository)
        basket_id = SecureRandom.uuid
        product_code = 'abcd'
        expect {
          interactor.call(basket_id, product_code, 1)
        }.to broadcast(:item_set, a_hash_including(items: {product_code => {price: 10, quantity: 1}}))
      end
    end

    context 'when item is in basket' do
      it 'increases quantity' do
        basket_id = SecureRandom.uuid
        product_code = "abcd"
        repository = FakeBasketRepository.new({product_code => {price: 10, quantity: 1}})
        interactor = described_class.new(repository)
        expect {
          interactor.call(basket_id, product_code, 1)
        }.to broadcast(:item_set, a_hash_including(items: {product_code => {price: 10, quantity: 2}}))
      end
    end

    context 'when quantity is 0 or less' do
      it 'remove items' do
        basket_id = SecureRandom.uuid
        product_id = SecureRandom.uuid
        repository = FakeBasketRepository.new({product_id => {price: 10, quantity: 1}})
        interactor = described_class.new(repository)
        expect {
          interactor.call(basket_id, product_id, -1)
        }.to broadcast(:item_set, a_hash_including(items: {}))
      end
    end
  end
end