class SearchController < ApplicationController
  def index
    if (Category.find(params["category"]).name == 'All')
      @products = Product.where("name LIKE ?", "%#{params[:search_term]}%")
    else
      @products = Product.where("name LIKE ? AND category_id LIKE ?", "%#{params[:search_term]}%", "%#{params['category']}%")
    end

  end
end
