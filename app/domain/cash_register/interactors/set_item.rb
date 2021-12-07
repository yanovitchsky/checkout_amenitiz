module CashRegister
  module Interactors
    class SetItem < ::Interactors::Base
      include Wisper::Publisher

      def call(id, product_id, quantity)
        basket = @repository.find(id)
        product = @repository.find_product(product_id)
        basket = @repository.set_item(id, product_id, quantity)
        broadcast(:item_set, basket)
      rescue ::Repositories::RecordNotFoundError
        broadcast(:basket_or_product_not_found)
      end
    end
  end
end