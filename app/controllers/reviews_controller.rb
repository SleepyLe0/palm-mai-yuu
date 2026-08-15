class ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params)

    if @review.save
      redirect_to @product, notice: "Thanks for reviewing #{@product.name}!"
    else
      render "products/show", status: :unprocessable_content
    end
  end

  private

  def review_params
    params.expect(review: [ :author_name, :rating, :comment ])
  end
end
