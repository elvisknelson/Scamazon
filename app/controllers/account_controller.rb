require 'bcrypt'

class AccountController < ApplicationController
  include BCrypt

  def index
    @user = User.find(session[:user].to_i)
    @pastorders = Order.where(user_id: session[:user].to_i, status: "Paid")
  end

  def sign_in
    if params[:user_name]
      user = User.where(username: params[:user_name]).first

      unless user.nil?
        password = BCrypt::Password.new(user.password)

        if (password == params[:password])
          session[:user] = user.id
          redirect_to root_path
        else
          redirect_to account_sign_in_path
        end
      end
    end
  end

  def sign_up
    if params[:user_name].present? && params[:province].present? && params[:address].present? && params[:password_1].present?
      if (params[:password_1] == params[:password_2])
        unless User.exists?(username: params[:user_name])
          password = BCrypt::Password.create(params[:password_1])
          user = User.create(username: params[:user_name], province_id: params[:province], street_address: params[:address], password: password)
          session[:user] = user.id
          redirect_to root_path
        else
          redirect_to account_sign_in_path
        end
      else
        redirect_to account_sign_up_path
      end
    end
  end

  def sign_out
    session[:user] = nil
    redirect_to root_path
  end
end
