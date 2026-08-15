class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :number, null: false
      t.string :full_name, null: false
      t.string :email, null: false
      t.string :status, null: false, default: "pending"
      t.decimal :total_amount, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :orders, :number, unique: true
    add_index :orders, :created_at
  end
end
