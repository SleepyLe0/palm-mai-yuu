class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true

  validates :product_name, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  def total_price
    quantity * unit_price
  end
end
