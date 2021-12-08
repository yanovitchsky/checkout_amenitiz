FactoryBot.define do
  factory :promotion do
    name { Faker::Alphanumeric.alpha(number: 10) }
    description { Faker::Lorem.sentence }
    conditions { "" }
    actions { "" }
    promo_type { "item_discount" }
  end

  factory :product do
    code  { Faker::Alphanumeric.alpha(number: 3) }
    name  { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
  end

  factory :basket do
  end
end