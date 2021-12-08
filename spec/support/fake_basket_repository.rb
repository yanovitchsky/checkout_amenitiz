class FakeBasketRepository
  attr_accessor :basket

  def initialize(basket={})
    @basket = basket
  end

  def find(id)
    @basket
  end

  def get(id)
    @basket
  end

  def find_product(code)
    0
  end

  def set_item(id, product_code, quantity)
    if @basket.has_key?(product_code) && quantity <= 0
      @basket.delete(product_code)
    elsif @basket.has_key?(product_code) && quantity > 0
      @basket[product_code][:quantity] += quantity
    else
      @basket[product_code] = {price: 10, quantity: 1}
    end
    total = @basket.reduce(0) do |sum, (key, value)|
      sum += value[:quantity] * value[:price]
    end
    {items: @basket, total: total}
  end
end