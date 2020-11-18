class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :load_cart

  def add_to_cart
    if session[:user]
      product_id = params[:id].to_i

      if ProductOrder.exists?(product_id: product_id, order_id: @current_order)
        order = ProductOrder.where(product_id: product_id, order_id: @current_order).first
        quantity = order.quantity + 1
        order.update(quantity: quantity)
      else
        ProductOrder.create(product_id: product_id, order_id: @current_order["id"], quantity: 1)
      end

      redirect_to root_path
    end
  end

  def update_cart
    ProductOrder.where(product_id: params[:id], order_id: @current_order["id"]).update(quantity: params[:quantity])
    redirect_to cart_index_path
  end

  def remove_from_cart

  end

  private

  def load_cart
    if session[:user]
      @current_orders = ProductOrder.where(order_id: @current_order)
    end
  end

  def initialize_session
    @current_orders ||= []
    session[:user] ||= nil

    if session[:user]
      if Order.where(user_id: session[:user], status: "pending").empty?
        @current_order = Order.create(user_id: session[:user], total_price: 0, pst_paid: 0, gst_paid: 0, hst_paid: 0, status: "pending")
      else
        @current_order = Order.where(user_id: session[:user], status: "pending").first
      end
    end
  end
end
