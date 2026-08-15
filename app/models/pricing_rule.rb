class PricingRule < ApplicationRecord
  belongs_to :product, optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate  :scoped_to_one_thing

  scope :active, -> {
    where("starts_at IS NULL OR starts_at <= ?", Time.current)
      .where("ends_at IS NULL OR ends_at >= ?", Time.current)
  }

  def apply(price) = raise NotImplementedError

  private
    def scoped_to_one_thing
      return if product_id.present? ^ category.present?
      errors.add(:base, "set exactly one of product or category")
    end
end
