class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def show

  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = current_shop.products.new(product_name: params[:product_name], product_description: params[:product_description], price: params[:price], quantity: params[:quantity], category_id: params[:category_id])
    @product.image.attach(params[:image])

    respond_to do |format|
      if @product.save
        format.html { redirect_to edit_shop_registration_path, notice: 'Product Added' }
      else
        format.html { render :new }
      end
    end
  end

  def update

    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @product = Product.find(params[:id])

    @product.destroy
    respond_to do |format|
      format.html { redirect_to edit_shop_registration_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :product_description, :price, :quantity, :category_id, :image)
  end




end
