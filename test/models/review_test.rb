require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  setup do
    @product = products(:one)
  end

  # Builds a review that is valid in every way, so each test below can
  # break exactly one thing and prove that one thing is what was checked.
  def build_review(overrides = {})
    @product.reviews.build({
      author_name: "Somchai",
      rating: 5,
      comment: "Great beans."
    }.merge(overrides))
  end

  test "a review with a name, a rating and a comment is valid" do
    assert build_review.valid?
  end

  test "a review belongs to the product it was built from" do
    assert_equal @product, build_review.product
  end

  test "a product only reports its own reviews" do
    assert_equal 2, @product.reviews.count
  end

  test "rating is required" do
    review = build_review(rating: nil)

    assert_not review.valid?
    assert_includes review.errors[:rating], "can't be blank"
  end

  test "rating of 1 through 5 is accepted" do
    (1..5).each do |stars|
      assert build_review(rating: stars).valid?, "expected #{stars} stars to be valid"
    end
  end

  test "rating below 1 is rejected" do
    assert_not build_review(rating: 0).valid?
  end

  test "rating above 5 is rejected" do
    assert_not build_review(rating: 6).valid?
  end

  test "author name is required" do
    review = build_review(author_name: "")

    assert_not review.valid?
    assert_includes review.errors[:author_name], "can't be blank"
  end

  test "author name longer than 50 characters is rejected" do
    assert_not build_review(author_name: "a" * 51).valid?
  end

  test "comment is required" do
    review = build_review(comment: "")

    assert_not review.valid?
    assert_includes review.errors[:comment], "can't be blank"
  end

  test "comment longer than 1000 characters is rejected" do
    assert_not build_review(comment: "a" * 1001).valid?
  end

  test "a review must belong to a product" do
    assert_not Review.new(author_name: "Somchai", rating: 5, comment: "Great.").valid?
  end

  test "deleting a product deletes its reviews" do
    assert_difference("Review.count", -2) do
      @product.destroy
    end
  end
end
