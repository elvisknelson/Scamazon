class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :load_cart

  def add_to_cart
    product_id = params[:id].to_i

    if session[:user]
      if ProductOrder.exists?(product_id: product_id, order_id: @current_order)
        order = ProductOrder.where(product_id: product_id, order_id: @current_order).first
        quantity = order.quantity + 1
        order.update(quantity: quantity)
      else
        ProductOrder.create(product_id: product_id, order_id: @current_order["id"], quantity: 1)
      end
    else
      if ProductOrder.exists?(product_id: product_id, order_id: @current_order)
        order = ProductOrder.where(product_id: product_id, order_id: @current_order).first
        quantity = order.quantity + 1
        order.update(quantity: quantity)
      else
        ProductOrder.create(product_id: product_id, order_id: @current_order["id"], quantity: 1)
      end
    end

    redirect_to root_path
  end

  def update_cart
    if (params[:quantity].to_i == 0)
      ProductOrder.where(product_id: params[:id], order_id: @current_order["id"]).first.destroy
    else
      ProductOrder.where(product_id: params[:id], order_id: @current_order["id"]).update(quantity: params[:quantity])
    end

    redirect_to cart_index_path
  end

  def remove_from_cart
    ProductOrder.where(product_id: params[:id], order_id: @current_order["id"]).first.destroy
    redirect_to cart_index_path
  end

  private

  def load_cart
    @current_orders = ProductOrder.where(order_id: @current_order)
  end

  def initialize_session
    @current_orders ||= []
    session[:user] ||= nil

    if session[:user]
      if Order.where(user_id: session[:user], status: "New").empty?
        @current_order = Order.create(user_id: session[:user], total_price: 0, pst_paid: 0, gst_paid: 0, hst_paid: 0, stripe_id: 0, status: "New")
      else
        @current_order = Order.where(user_id: session[:user], status: "New").first
      end
    else
      if Order.where(user_id: -1, status: "New").empty?
        @current_order = Order.create(user_id: -1, total_price: 0, pst_paid: 0, gst_paid: 0, hst_paid: 0, stripe_id: 0, status: "New")
      else
        @current_order = Order.where(user_id: -1, status: "New").first
      end
    end
  end
end
