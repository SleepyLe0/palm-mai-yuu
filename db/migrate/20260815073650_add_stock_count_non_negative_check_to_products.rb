class AddStockCountNonNegativeCheckToProducts < ActiveRecord::Migration[8.1]
  def change
    add_check_constraint :products, "stock_count >= 0", name: "products_stock_count_non_negative"
  end
end
