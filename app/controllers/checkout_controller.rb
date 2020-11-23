class CheckoutController < ApplicationController
  def create

    if params[:id].to_i > 0
      product = Product.find(params[:id])

      if product.nil?
        redirect_to root_path
        return
      end

      @session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: product.name,
          description: product.description,
          amount: product.price,
          currency: 'cad',
          quantity: 1
        }],
        success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: checkout_cancel_url
      )
    else

      unless params[:province].nil?
        prov = Province.find(params[:province])
      else
        prov = User.find(session[:user]).province
      end

      price = 0
      description = ""
      @current_orders.each do |prodorder|
        item = Product.find(prodorder["product_id"])
        price += item["price"] * prodorder["quantity"]
        description += '\'' + prodorder["quantity"].to_s + " x " + item["name"] + "\'\n"
      end

      @session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: "Scamazon Order",
          description: description,
          amount: price,
          currency: 'cad',
          quantity: 1
        }],
        success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: checkout_cancel_url
      )
    end

    respond_to do |format|
      format.js # render create.js.erb
    end
  end

  def success
    unless @current_orders.nil?
      @session = Stripe::Checkout::Session.retrieve(params[:session_id])
      @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

      order = Order.find(@current_order["id"])
      user = User.find(session[:user]) #TODO FIX THIS
      price = 0.00
      @current_orders.each do |prodorder|
        item = Product.find(prodorder["product_id"])
        price += item["price"] * prodorder["quantity"]
      end
      price += price * (user.province.pst + user.province.gst + user.province.hst)
      order.update(status: "Paid", total_price: price, gst_paid: user.province.gst, pst_paid: user.province.pst, hst_paid: user.province.hst, stripe_id: @session["id"])
      order.save

      @previous_order = @current_order
      @current_orders = []
      @current_order = nil
    end
  end

  def guest;
  end

  def cancel;
  end
end
