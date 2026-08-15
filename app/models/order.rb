class Order < ApplicationRecord
  has_secure_token :number

  has_many :order_items, dependent: :destroy

  enum :status, { pending: "pending", cancelled: "cancelled" }, validate: true

  validates :full_name, presence: true
  validates :email, presence: true
  validates :order_items, presence: { message: "can't be empty" }
  validate :items_within_stock, on: :create

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

  after_create :take_stock

  def to_param
    number
  end

  private

  def take_stock
    order_items.each { |item| item.product&.decrement!(:stock_count, item.quantity) }
  end

  def items_within_stock
    order_items.each do |item|
      next if item.product.nil?

      available = item.product.stock_count.to_i
      if item.quantity.to_i > available
        message = available.zero? ? "is out of stock" : "only #{available} left in stock"
        errors.add(:base, "#{item.product_name} #{message}")
      end
    end
  end
end
