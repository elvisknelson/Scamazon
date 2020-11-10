class ProductController < ApplicationController

  def index
    @categories = Category.where.not(name: 'All')
    @products = Product.all()
  end

  def show
    @product = Product.find(params[:id])
  end
end
