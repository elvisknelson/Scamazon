class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :load_cart

  def add_to_cart
    if session[:user]
      id = params[:id].to_i
      order_id = @current_order["id"].to_i

      @test = Order.find(order_id)

      redirect_to root_path
    end
  end

  def update_cart

  end

  def remove_from_cart

  end

  private

  def load_cart
    if session[:user]
      order = Order.where(user_id: session[:user], status: "pending").first
      @current_orders = ProductOrder.where(order_id: order["id"])
    end
  end

  def initialize_session
    @current_orders ||= []
    session[:user] ||= nil

    if Order.where(user_id: session[:user], status: "pending").empty?
      @current_order = Order.create(user_id: session[:user], status: "pending")
    else
      @current_order = Order.where(user_id: session[:user], status: "pending").first
    end
  end
end
