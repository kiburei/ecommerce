class HomeController < ApplicationController
  def index
    @shop = Shop.last
    @top_products = Product.order(rating: :desc).limit(4)
    @latest_products = Product.last(4)
  end
end
