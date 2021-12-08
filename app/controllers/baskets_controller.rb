class BasketsController < ApplicationController

  def show
    interactor = CashRegister::Interactors::GetBasket.new(repository)
    interactor.on(:basket_not_found) do
      render json: {error: 'Basket not found'}, status: :not_found
    end

    interactor.on(:basket_found) do |basket|
      render json: basket, status: :ok
    end

    interactor.call(params[:id])
  end

  def create
    interactor = CashRegister::Interactors::CreateBasket.new(repository)
    interactor.on(:basket_created) do |basket|
      render json: basket, status: :created
    end
    interactor.call
  end

  def update
    interactor = CashRegister::Interactors::SetItem.new(repository)
    interactor.on(:item_set) do |basket|
      render json: basket, status: :created
    end
    interactor.call(params[:id], params[:code], params[:quantity].to_i)
  end

  def checkout
    interactor = CashRegister::Interactors::Checkout.new(repository)
    interactor.on(:checked_out) do |basket|
      render json: basket, status: :created
    end
    interactor.call(params[:id])
  end

  private
  def repository
    CashRegister::Repositories::Basket.new
  end
end
