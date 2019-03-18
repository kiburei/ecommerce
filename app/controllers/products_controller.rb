class ProductsController < ApplicationController

  def create
    @product = current_shop.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to edit_shop_registration_path, notice: 'Product Added' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def product_params
    params.permit(:product_name, :product_description, :price, :quantity,  :category_id)
  end



end
