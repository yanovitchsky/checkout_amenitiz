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

  def find_product(id)
    0
  end

  def set_item(id, product_id, quantity)
    if @basket.has_key?(product_id) && quantity <= 0
      @basket.delete(product_id)
    elsif @basket.has_key?(product_id) && quantity > 0
      @basket[product_id][:quantity] += quantity
    else
      @basket[product_id] = {price: 10, quantity: 1}
    end

    @basket
  end
end