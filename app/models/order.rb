class Order < ApplicationRecord
  has_secure_token :number

  has_many :order_items, dependent: :destroy

  enum :status, { pending: "pending", cancelled: "cancelled" }, validate: true

  validates :full_name, presence: true
  validates :email, presence: true
  validates :order_items, presence: { message: "can't be empty" }

  def self.build_from_cart(cart, attributes)
    new(attributes).tap do |order|
      cart.cart_items.includes(:product).each do |item|
        order.order_items.build(
          product: item.product,
          product_name: item.product.name,
          unit_price: item.unit_price,
          quantity: item.quantity
        )
      end

      order.total_amount = cart.total_price
    end
  end

  def to_param
    number
  end
end
