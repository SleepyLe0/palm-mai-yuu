class Review < ApplicationRecord
  MAX_RATING = 5
  MAX_AUTHOR_NAME_LENGTH = 50
  MAX_COMMENT_LENGTH = 1000

  belongs_to :product

  validates :author_name, presence: true, length: { maximum: MAX_AUTHOR_NAME_LENGTH }
  validates :rating, presence: true, inclusion: { in: 1..MAX_RATING }
  validates :comment, presence: true, length: { maximum: MAX_COMMENT_LENGTH }

  scope :newest_first, -> { order(created_at: :desc) }
end
