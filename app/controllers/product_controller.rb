class ProductController < ApplicationController
  def index
    @categories = Category.all()
    @products = Product.all()
  end

  def show
    @product = Product.find(params[:id])
  end
end
