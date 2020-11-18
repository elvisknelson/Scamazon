class ProductController < ApplicationController

  def index
    @categories = Category.where.not(name: 'All')
    @products = Product.all()
  end

  def sale
    @categories = Category.where.not(name: 'All')
    @products = Product.where(on_sale: true)
  end

  def rating
    @categories = Category.where.not(name: 'All')
    @products = Product.where("rating >= #{params[:rating]}")
  end

  def new
    @products = Product.where("created_at > ?", 3.days.ago)
  end

  def show
    @product = Product.find(params[:id])
  end
end
