module CashRegister
  module Repositories
    class Basket < ::Repositories::Base

      def find_product(id)
        Repositories::Product.find(id)
      end

      private
      def entity
        ::Basket
      end
    end
  end
end