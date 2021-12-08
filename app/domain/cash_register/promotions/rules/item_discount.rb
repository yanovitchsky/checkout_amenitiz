module CashRegister
  module Promotions
    module Rules
      class ItemDiscount
        def initialize(repository, basket_id)
          @repository = repository
          @basket_id = basket_id
        end

        # conditions = {product_code: 'Adc', min_item: 3}
        # actions = [
        #   {type: 'add_item', code: 'abc', discount: 2},
        #   {type: 'adjust_price_ratio', code: 'abcd', discount: '2/3'},
        #   {type: 'adjust_price_amount', code: 'abcd', discount: 0.5},
        # ]
        
        def apply(conditions, actions)
          if eligible?(conditions)
            return actions.reduce(0) do |sum, action|
              klass = get_action_class(action['type'])
              aktion = klass.new(@repository)
              sum += aktion.apply(@basket_id, action['product_code'], action['discount'])
            end
          end
          return 0
        end

        def eligible?(conditions)
          basket = @repository.get(@basket_id)
          product_code = conditions['product_code']
          min_item = conditions['min_item']
          basket.has_key?(product_code) && basket[product_code][:quantity] >= min_item
        end

        private
        def get_action_class(type)
          "CashRegister::Promotions::Actions::#{type.classify}".constantize
        end
      end
    end
  end
end