class CheckoutController < ApplicationController
  def create

    unless params[:province].nil?
      prov = Province.find(params[:province])
    else
      prov = User.find(session[:user]).province
    end

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
        success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}&province=' + prov.id.to_s,
        cancel_url: checkout_cancel_url
      )
    end

    respond_to do |format|
      format.js # render create.js.erb
    end
  end

  def success
    if @current_orders.any?
      @session = Stripe::Checkout::Session.retrieve(params[:session_id])
      @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

      order = Order.find(@current_order["id"])
      price = 0.00
      @current_orders.each do |prodorder|
        item = Product.find(prodorder["product_id"])
        price += item["price"] * prodorder["quantity"]
      end
      prov = Province.find(params[:province].to_i)
      price += price * (prov.pst + prov.gst + prov.hst)
      order.update(status: "Paid", total_price: price, gst_paid: prov.gst, pst_paid: prov.pst, hst_paid: prov.hst, stripe_id: @session["id"])
      order.save

      @previous_order = Order.find(@current_order["id"])
      @current_orders = []
    end
  end

  def guest
    if params[:id]
      ProductOrder.create(product_id: params[:id], order_id: @current_order["id"], quantity: 1)
    end
  end

  def cancel;
  end
end
