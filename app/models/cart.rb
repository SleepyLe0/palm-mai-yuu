class Cart < ApplicationRecord
  enum :status, { active: "active", abandoned: "abandoned", completed: "completed" }, validate: true

  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_price
    cart_items.sum { |item| item.quantity * item.unit_price }
  end

  def total_quantity
    cart_items.sum(:quantity)
  end
end
