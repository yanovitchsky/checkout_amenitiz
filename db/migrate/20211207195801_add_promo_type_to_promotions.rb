class AddPromoTypeToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :promo_type, :string, null: false
  end
end
