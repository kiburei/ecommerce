class HomeController < ApplicationController

  def index
    if Shop.count > 0
      @shop = Shop.last
      @top_products = Product.order(rating: :desc).limit(4)
      @latest_products = Product.last(4)
    else
      redirect_to new_shop_registration_path
    end
  end

end
