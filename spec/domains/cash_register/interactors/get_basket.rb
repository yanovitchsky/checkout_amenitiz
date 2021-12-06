require 'rails_helper'

RSpec.describe CashRegister::Interactors::GetBasket do
  describe '.call' do
    let(:basket) { FactoryBot.build(:basket, id: SecureRandom.uuid) }
    
    it 'get a basket' do
      repo = fake(:repository, all: products) {CashRegister::Repositories::Basket}
      interactor = described_class.new(repo)
      expect { interactor.call(basket.id) }.to broadcast(:basket, basket)
    end
  end
end