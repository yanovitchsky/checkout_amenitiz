module CashRegister
  module Promotions
    module Actions
      class AddItem
        def initialize(repository)
          @repository = repository
        end
        def apply(basket_id, item_code, quantity)
          @repository.set_item(basket_id, item_code, quantity)
          0
        end
      end
    end
  end
end