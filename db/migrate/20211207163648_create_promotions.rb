class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions, id: :uuid do |t|
      t.string :name, :null => false, unique: true
      t.text :description
      t.jsonb :conditions, null: false
      t.jsonb :actions, null: false

      t.timestamps
    end
  end
end
