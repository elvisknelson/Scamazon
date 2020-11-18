class AccountController < ApplicationController
  def index
    @user = User.find(session[:user].to_i)

  end

  def sign_in
    if params[:user_name]
      user = User.where(username: params[:user_name], password: params[:password]).first

      unless (user.nil?)
        session[:user] = user.id
        redirect_to root_path
      else
        redirect_to account_index_path
      end
    end
  end

  def sign_up
    if params[:user_name]
      if (params[:password_1] == params[:password_2])
        unless User.exists?(username: params[:user_name])
          user = User.create(username: params[:user_name], province_id: 7, street_address: params[:address], password: params[:password_1])
          session[:user] = user.id
          redirect_to root_path
        else
          redirect_to account_sign_in_path
        end
      else
        redirect_to account_index_path
      end
    end
  end

  def sign_out
    session[:user] = nil
    redirect_to root_path
  end
end
