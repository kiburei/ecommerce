class HomeController < ApplicationController
  def index
    @top_products = Product.order(rating: :desc).limit(4)
    @latest_products = Product.last(4)
  end
end
