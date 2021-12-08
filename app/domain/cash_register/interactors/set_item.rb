module CashRegister
  module Interactors
    class SetItem < ::Interactors::Base
      include Wisper::Publisher

      def call(id, product_code, quantity)
        basket = @repository.find(id)
        product = @repository.find_product(product_code)
        basket = @repository.set_item(id, product_code, quantity)
        broadcast(:item_set, basket)
      rescue ::Repositories::RecordNotFoundError
        broadcast(:basket_or_product_not_found)
      end
    end
  end
end