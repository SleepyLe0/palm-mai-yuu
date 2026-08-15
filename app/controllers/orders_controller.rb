class OrdersController < ApplicationController
  def index
    @orders = visible_orders.order(created_at: :desc)
  end

  def show
    @order = visible_orders.includes(:order_items).find_by!(number: params[:number])
  end

  def new
    if current_cart.cart_items.empty?
      redirect_to cart_path, alert: "Your cart is empty." and return
    end

    @order = Order.new
  end

  def create
    @order = Order.build_from_cart(current_cart, order_params)

    if @order.save
      complete_checkout(@order)
      redirect_to @order, notice: "Order placed."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def visible_orders
    Order.where(id: session.fetch(:order_ids, []))
  end

  def complete_checkout(order)
    current_cart.completed!
    session.delete(:cart_id)
    session[:order_ids] = session.fetch(:order_ids, []) + [ order.id ]
  end

  def order_params
    params.require(:order).permit(:full_name, :email)
  end
end
