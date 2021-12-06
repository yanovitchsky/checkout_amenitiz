class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :code, null: false, unique: true, index: true
      t.string :name, null: false
      t.integer :price, default: 0, null: false

      t.timestamps
    end
  end
end
