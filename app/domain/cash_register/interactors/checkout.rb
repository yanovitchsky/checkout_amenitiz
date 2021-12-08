module CashRegister
  module Interactors
    class Checkout < ::Interactors::Base
      include Wisper::Publisher

      def call(id)
        discount = apply_discount(id)
        # raise discount.inspect
        basket = @repository.get(id)
        with_discount = basket[:total] - discount
        basket = @repository.get(id)
        basket[:with_discount] = with_discount
        broadcast(:checked_out, basket)
      rescue ::Repositories::RecordNotFoundError
        broadcast(:basket_or_product_not_found)
      end

      private
      def get_rule_class(type)
        "CashRegister::Promotions::Rules::#{type.classify}".constantize
      end

      def apply_discount(basket_id)
        ::Promotion.all.reduce(0) do |sum, promotion|
          klass = get_rule_class(promotion.promo_type)
          rule = klass.new(@repository, basket_id)
          amount = rule.apply(promotion.conditions, promotion.actions)
          p "#{promotion.name} => #{amount} "
          sum += amount
        end
      end
    end
  end
end