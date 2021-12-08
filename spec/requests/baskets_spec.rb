require 'rails_helper'

RSpec.describe "Baskets", type: :request do
  describe "POST /baskets" do
    it 'create a new basket' do
      post '/baskets'
      expect(response.body).to eq({items: {}, total: 0}.to_json)
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /baskets/:id" do
    context 'when basket does not exist' do
      it ' return an error' do
        get "/baskets/#{SecureRandom.uuid}"
        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({error: 'Basket not found'}.to_json)
      end
    end

    context 'when basket exists' do
      before do
        @product = FactoryBot.create(:product)
        @basket = FactoryBot.create(:basket)
        @basket.line_items.create(product_id: @product.id, quantity: 1)
      end
  
      it 'return basket by id' do
        res = { 
          items: {
            @product.code => {
              price: @product.price,
              quantity: 1
            }
          },
          total: @product.price
        }

        get "/baskets/#{@basket.id}"
        
        expect(response).to have_http_status(:success)
        expect(response.body).to eq(res.to_json)
      end
    end
  end

  describe 'PATCH /baskets/:id' do
    before do
      @product = FactoryBot.create(:product)
      @basket = FactoryBot.create(:basket)
    end
    it 'adds a new item to the basket' do
      res = { 
        items: {
          @product.code => {
            price: @product.price,
            quantity: 2
          }
        },
        total: @product.price * 2
      }

      patch  "/baskets/#{@basket.id}", :params => { code: @product.code, quantity: 2 }
        
      expect(response).to have_http_status(:success)
      expect(response.body).to eq(res.to_json)
    end
  end
end
