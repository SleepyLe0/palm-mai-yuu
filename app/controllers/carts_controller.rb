class CartsController < ApplicationController
  def show
    @cart = current_cart
    @products = Product.all
  end
end
