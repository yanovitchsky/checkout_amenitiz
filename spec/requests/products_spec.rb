require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create_list(:product, 3)
    end
    it "returns list of products" do
      get "/products"
      expect(response.body).to eq(Product.all.to_json)
      expect(response).to have_http_status(:success)
    end
  end

end
