class CategoryController < ApplicationController
  def index
    @categories = Category.where.not(name: 'All')
  end

  def show
    @category = Category.where(id: params[:id]).first
    @products = Product.where(category_id: params[:id])
  end
end
