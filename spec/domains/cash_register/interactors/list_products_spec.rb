require 'rails_helper'

RSpec.describe CashRegister::Interactors::ListProducts do
  describe '.call' do
    let(:products) { FactoryBot.build_list(:product, 3) }
    
    it 'list all products' do
      repo = fake(:repository, all: products) {CashRegister::Repositories::Product}
      interactor = described_class.new(repo)
      expect { interactor.call }.to broadcast(:list_products, products)
    end
  end
end