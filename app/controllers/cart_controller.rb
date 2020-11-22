class CartController < ApplicationController
  def index
    if session[:user]
      @user = User.find(session[:user])
    else
      @user = User.find(23) #TODO FIX THIS
    end

    @total = 0.00
  end
end
