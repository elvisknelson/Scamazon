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
      price = 0
      description = ""
      @current_orders.each do |prodorder|
        item = Product.find(prodorder["product_id"])
        price += item["price"] * prodorder["quantity"]
        description += '\'' + item["name"] + "\'\n"
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
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    testt = Order.find(@current_order["id"])
    testt.update(status: "Paid")
    testt.save
    @current_orders = []
  end

  def cancel;
  end
end
