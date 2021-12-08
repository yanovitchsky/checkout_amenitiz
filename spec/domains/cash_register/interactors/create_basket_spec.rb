require 'rails_helper'

RSpec.describe CashRegister::Interactors::CreateBasket do
  describe '#call' do
    it 'creates basket' do
      interactor = described_class.new(CashRegister::Repositories::Basket.new)
      expect(interactor.call).to broadcast(:basket_created, a_hash_including({items: {}, total: 0}))
    end
  end
end