class ProductsController < ApplicationController
  def index
    interactor = CashRegister::Interactors::ListProducts.new(repository)
    interactor.on(:list_products) do |products|
      render json: products, status: 200
    end
    interactor.call
  end

  private
  def repository
    CashRegister::Repositories::Product.new
  end
end
