class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [ :update, :destroy ]

  def create
    product = Product.find(cart_item_params[:product_id])
    cart_item = current_cart.cart_items.find_or_initialize_by(product: product)
    requested_quantity = cart_item_params.fetch(:quantity, 1).to_i

    if cart_item.new_record?
      cart_item.unit_price = product.price
      cart_item.quantity = requested_quantity
    else
      cart_item.quantity += requested_quantity
    end

    if cart_item.save
      redirect_to cart_path, notice: "Added #{product.name} to cart."
    else
      redirect_to cart_path, alert: cart_item.errors.full_messages.to_sentence
    end
  end

  def update
    if @cart_item.update(quantity: cart_item_params[:quantity])
      redirect_to cart_path, notice: "Cart updated."
    else
      redirect_to cart_path, alert: @cart_item.errors.full_messages.to_sentence
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_path, notice: "Removed from cart."
  end

  private

  def set_cart_item
    @cart_item = current_cart.cart_items.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
