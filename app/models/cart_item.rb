class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, uniqueness: { scope: :cart_id }
  validate :quantity_within_stock

  private

  def quantity_within_stock
    return if product.nil? || quantity.nil?

    if product.stock_count.to_i.zero?
      errors.add(:base, "#{product.name} is out of stock")
    elsif quantity > product.stock_count
      errors.add(:quantity, "only #{product.stock_count} of #{product.name} left in stock")
    end
  end
end
