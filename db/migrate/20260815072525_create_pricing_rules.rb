class CreatePricingRules < ActiveRecord::Migration[8.1]
  def change
    create_table :pricing_rules do |t|
      t.string :type
      t.integer :product_id
      t.string :category
      t.decimal :amount, precision: 10, scale: 2
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
    add_index :pricing_rules, :product_id
    add_index :pricing_rules, :category
  end
end
