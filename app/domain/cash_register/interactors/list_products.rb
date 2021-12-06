module CashRegister
  module Interactors
    class ListProducts < ::Interactors::Base
      include Wisper::Publisher

      def call
        products = @repository.all
        broadcast(:list_products, products)
      end
    end
  end
end