class CreateOrderItems < ActiveRecord::Migration[8.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, foreign_key: { on_delete: :nullify }
      t.string :product_name, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
