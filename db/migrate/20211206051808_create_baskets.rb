class CreateBaskets < ActiveRecord::Migration[6.0]
  def change
    create_table :baskets, id: :uuid do |t|

      t.timestamps
    end
  end
end
