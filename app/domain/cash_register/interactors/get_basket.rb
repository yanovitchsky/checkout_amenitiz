module CashRegister
  module Interactors
    class GetBasket < ::Interactors::Base
      include Wisper::Publisher

      def call(id)
        basket = @repository.find(id)
        broadcast(:basket_found, basket)
      rescue ::Repositories::RecordNotFoundError
        broadcast(:basket_not_found)
      end
    end
  end
end