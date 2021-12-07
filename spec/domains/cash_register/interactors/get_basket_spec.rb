require 'rails_helper'

RSpec.describe CashRegister::Interactors::GetBasket do
  describe '.call' do
    let(:basket) { FactoryBot.build(:basket, id: SecureRandom.uuid) }
    
    context 'when basket does not exist' do
      it 'broadcast not_found' do
        repo = fake(:repository) {CashRegister::Repositories::Basket}
        stub(repo).find(any_args) { raise Repositories::RecordNotFoundError}
        interactor = described_class.new(repo)
        expect { interactor.call(SecureRandom) }.to broadcast(:basket_not_found)
      end
    end

    context 'when basket exist' do
      it 'broadcast found with basket' do
        repo = fake(:repository, find: basket) {CashRegister::Repositories::Basket}
        interactor = described_class.new(repo)
        expect { interactor.call(basket.id) }.to broadcast(:basket_found, basket)
      end
    end
  end
end