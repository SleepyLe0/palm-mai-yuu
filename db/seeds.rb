# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

COFFEE_PRODUCTS = [
  # Single-Origin Beans
  { name: "Ethiopia Yirgacheffe", category: "Single-Origin Beans", price: 16.99, stock_count: 120 },
  { name: "Colombia Huila Supremo", category: "Single-Origin Beans", price: 15.49, stock_count: 140 },
  { name: "Sumatra Mandheling", category: "Single-Origin Beans", price: 17.25, stock_count: 95 },
  { name: "Guatemala Antigua", category: "Single-Origin Beans", price: 16.50, stock_count: 110 },

  # Coffee Blends
  { name: "Breakfast Blend", category: "Coffee Blends", price: 12.99, stock_count: 200 },
  { name: "French Roast Blend", category: "Coffee Blends", price: 13.49, stock_count: 180 },
  { name: "Espresso Blend", category: "Coffee Blends", price: 14.99, stock_count: 160 },
  { name: "Decaf House Blend", category: "Coffee Blends", price: 13.99, stock_count: 130 },

  # Ready-to-Drink
  { name: "Cold Brew Concentrate 32oz", category: "Ready-to-Drink", price: 10.99, stock_count: 80 },
  { name: "Nitro Cold Brew Can 11oz", category: "Ready-to-Drink", price: 3.49, stock_count: 300 },
  { name: "Vanilla Oat Milk Latte 8oz", category: "Ready-to-Drink", price: 4.29, stock_count: 250 },
  { name: "Vietnamese Iced Coffee Can 8oz", category: "Ready-to-Drink", price: 3.99, stock_count: 220 },
].freeze

COFFEE_PRODUCTS.each do |attrs|
  product = Product.find_or_initialize_by(name: attrs[:name])
  product.update!(attrs)
end
