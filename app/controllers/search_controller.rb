class SearchController < ApplicationController
  def index
    @search = params["search"]
    if @search.present?
      @name = @search["name"]
      @products = Product.where("name LIKE ?", "%#{@name}%")
    end
  end
end
