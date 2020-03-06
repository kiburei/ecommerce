class WishlistController < ApplicationController

    def index
        @products = Product.all
    end

    def show 
        @product = Product.find(params[:id])
    end     

    def destroy
        @product = Product.find(params[:id])
        @product.destroy

        redirect_to wishlist_path
      end

    

end    