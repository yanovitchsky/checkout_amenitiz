FactoryBot.define do
  factory :product do
    code  { Faker::Alphanumeric.alpha(number: 3) }
    name  { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
  end

  factory :basket do
  end
end