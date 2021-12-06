module CashRegister
  module Repositories
    class Product < ::Repositories::Base

      private
      def entity
        ::Product
      end
    end
  end
end