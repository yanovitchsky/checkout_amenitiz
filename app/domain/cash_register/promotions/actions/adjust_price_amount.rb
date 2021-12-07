module CashRegister
  module Promotions
    module Actions
      class AdjustPriceAmount
        def initialize(repository)
          @repository = repository
        end
        def apply(basket_id, item_code, price)
          basket = @repository.get(basket_id)
          return 0 unless basket.has_key?(item_code)
          basket[item_code][:quantity] * price
        end
      end
    end
  end
end