# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  green_tea = Product.create!(name: 'Green Tea', code: 'GR1', price: 3.11)
  strawberry = Product.create!(name: 'Strawberries', code: 'SR1', price: 5.0)
  coffee = Product.create!(name: 'Coffe', code: 'CF1', price: 11.23)

  Promotion.create!(
    promo_type: 'item_discount',
    name: 'BOGO',
    description: 'Buy one get on free on Green teas',
    conditions: {
      product_code: green_tea.code,
      min_item: 1
    },
    actions: [
      {
        type: 'add_item',
        product_code: green_tea.code,
        discount: 1
      },
      {
        type: 'adjust_amount',
        product_code: green_tea.code,
        discount: green_tea.price
      }
    ]
  )

  Promotion.create!(
    promo_type: 'item_discount',
    name: 'Bulk Strawberries',
    description: 'Buy 3 or more strawberries',
    conditions: {
      product_code: strawberry.code,
      min_item: 3
    },
    actions: [
      {
        type: 'adjust_price_amount',
        product_code: strawberry.code,
        discount: 0.5
      }
    ]
  )

  Promotion.create!(
    promo_type: 'item_discount',
    name: 'Coffee Addict',
    description: 'Buy 3 or more strawberries',
    conditions: {
      product_code: coffee.code,
      min_item: 3
    },
    actions: [
      {
        type: 'adjust_price_ratio',
        product_code: coffee.code,
        discount: '2/3'
      }
    ]
  )
end