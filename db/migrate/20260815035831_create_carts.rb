class CreateCarts < ActiveRecord::Migration[8.1]
  def change
    create_table :carts do |t|
      t.string :status, null: false, default: "active"

      t.timestamps
    end
  end
end
