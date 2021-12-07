module CashRegister
  module Repositories
    class Basket < ::Repositories::Base

      def find_product(id)
        Repositories::Product.new.find(id)
      end

      def set_item(id, product_id, quantity)
        basket = find(id)
        product = find_product(product_id)
        line_item = basket.line_items.where(product_id: product_id).first
        if line_item.nil? && quantity > 0
          basket.line_items.create(quantity: quantity, product: product)
        elsif !line_item.nil? && quantity > 0
          line_item.update(quantity: line_item.quantity + quantity)
        else
          line_item.destroy
        end
        basket_result(basket)
      end

      private
      def entity
        ::Basket
      end

      def basket_result(basket)
        basket.line_items.each_with_object({}) do |line_item, hash|
          hash[line_item.product_id] = {price: line_item.product.price, quantity: line_item.quantity}
        end
      end
    end
  end
end