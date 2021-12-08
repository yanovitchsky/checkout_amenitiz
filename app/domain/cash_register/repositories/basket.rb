module CashRegister
  module Repositories
    class Basket < ::Repositories::Base

      def find_product(code)
        result = Repositories::Product.new.filter_by(:code, code)
      end

      def get(id)
        basket = find(id)
        basket_result(basket)
      end

      def set_item(id, product_code, quantity)
        basket = find(id)
        product = find_product(product_code).first
        raise ::Repositories::RecordNotFoundError if product.nil?
        line_item = basket.line_items.where(product_id: product.id).first
        if line_item.nil? && quantity > 0
          basket.line_items.create(quantity: quantity, product: product)
        else
          line_item.quantity + quantity <= 0 ? line_item.destroy : line_item.update(quantity: line_item.quantity + quantity)
        end
        basket_result(basket)
      end

      private
      def entity
        ::Basket
      end

      # methods below should belong to a dto

      def basket_result(basket)
        items = basket.line_items.each_with_object({}) do |line_item, hash|
          hash[line_item.product.code] = {price: line_item.product.price, quantity: line_item.quantity, name: line_item.product.name}
        end
        total = get_total(items)
        {id: basket.id, items: items, total: total}
      end

      def get_total(basket_result)
        total = basket_result.reduce(0) do |sum, (key, value)|
          sum += value[:quantity] * value[:price]
        end
        discount = ::Promotion.all.reduce(0) do |sum, promotion|
          klass = get_rule_class(promotion.promo_type)
          rule = klass.new(@repository)
          sum += rule.apply(promotion.conditions, promotion.actions)
        end
        total - discount
      end

      def get_rule_class(type)
        "CashRegister::Promotions::Rules::#{type.classify}".constantize
      end
    end
  end
end