class PercentageDiscount < PricingRule
  validates :amount, numericality: { less_than: 100 }

  def apply(price) = (price * (1 - amount / 100)).round(2)
end
