class Product < ApplicationRecord
  enum :category, {
    single_origin_beans: "Single-Origin Beans",
    coffee_blends: "Coffee Blends",
    ready_to_drink: "Ready-to-Drink"
  }, validate: true
end
