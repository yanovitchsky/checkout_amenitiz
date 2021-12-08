module CashRegister
  module Interactors
    class CreateBasket < ::Interactors::Base
      include Wisper::Publisher

      def call
        new_basket = @repository.create({})
        basket = @repository.get(new_basket.id)
        broadcast(:basket_created, basket)
      end
    end
  end
end