module CashRegister
  module Promotions
    module Actions
      class AdjustPriceAmount
        def initialize(repository)
          @repository = repository
        end
        def apply(basket_id, item_code, price)
          Rails.logger.info "apply amount adjusment"
          basket = @repository.get(basket_id)
          return 0 unless basket[:items].has_key?(item_code)
          basket[:items][item_code][:quantity] * price
        end
      end
    end
  end
end