class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :pricing_rules, dependent: :destroy
  
  enum :category, {
    single_origin_beans: "Single-Origin Beans",
    coffee_blends: "Coffee Blends",
    ready_to_drink: "Ready-to-Drink"
  }, validate: true

  def applicable_rules
    PricingRule.active.where(product: [ self, nil ]).where(category: [ category, nil ])
  end
  
  def current_price
    applicable_rules.map { |r| r.apply(price) }.min || price
  end
  
  def on_sale? = current_price < price
end
