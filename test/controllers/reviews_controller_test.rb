require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  def valid_review_params(overrides = {})
    { review: {
      author_name: "Somchai",
      rating: 5,
      comment: "Best beans I have bought all year."
    }.merge(overrides) }
  end

  test "leaving a valid review saves it and returns to the product page" do
    assert_difference("Review.count", 1) do
      post product_reviews_url(@product), params: valid_review_params
    end

    assert_redirected_to product_url(@product)
  end

  test "a new review is attached to the product named in the URL" do
    post product_reviews_url(@product), params: valid_review_params

    assert_equal @product, Review.last.product
  end

  test "a review with no rating is rejected" do
    assert_no_difference("Review.count") do
      post product_reviews_url(@product), params: valid_review_params(rating: nil)
    end

    assert_response :unprocessable_content
  end

  test "a rating above 5 is rejected" do
    assert_no_difference("Review.count") do
      post product_reviews_url(@product), params: valid_review_params(rating: 99)
    end

    assert_response :unprocessable_content
  end

  test "a review with no comment is rejected" do
    assert_no_difference("Review.count") do
      post product_reviews_url(@product), params: valid_review_params(comment: "")
    end

    assert_response :unprocessable_content
  end

  test "a rejected review comes back with its error message on screen" do
    post product_reviews_url(@product), params: valid_review_params(rating: 99)

    assert_match "Rating is not included in the list", response.body
  end

  test "a rejected review comes back with what the visitor already typed" do
    post product_reviews_url(@product), params: valid_review_params(rating: 99, author_name: "Malee")

    assert_match "Malee", response.body
  end

  test "a visitor cannot attach their review to a different product" do
    other_product = products(:two)

    post product_reviews_url(@product), params: valid_review_params(product_id: other_product.id)

    assert_equal @product, Review.last.product
  end
end
