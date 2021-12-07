module CashRegister
  module Promotions
    module Actions
      class AdjustPriceRatio
        def initialize(repository)
          @repository = repository
        end
        def apply(basket_id, item_code, rational)
          basket = @repository.get(basket_id)
          return 0 unless basket.has_key?(item_code)
          total_price = basket[item_code][:quantity] * basket[item_code][:price]
          reduced_price = basket[item_code][:quantity] * basket[item_code][:price] * rational
          total_price - reduced_price
        end
      end
    end
  end
end