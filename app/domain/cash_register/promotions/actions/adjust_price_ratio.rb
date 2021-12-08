module CashRegister
  module Promotions
    module Actions
      class AdjustPriceRatio
        def initialize(repository)
          @repository = repository
        end
        def apply(basket_id, item_code, rational)
          Rails.logger.info "apply ratio adjusment"
          basket = @repository.get(basket_id)
          return 0 unless basket[:items].has_key?(item_code)
          total_price = basket[:items][item_code][:quantity] * basket[:items][item_code][:price]
          reduced_price = basket[:items][item_code][:quantity] * basket[:items][item_code][:price] * Rational(rational)
          total_price - reduced_price
        end
      end
    end
  end
end