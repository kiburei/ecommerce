class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def show
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = current_shop.categories.new(category_name: params[:category_name])
    @category.image.attach(params[:image])

    respond_to do |format|
      if @category.save
        format.html { redirect_to edit_shop_registration_path, notice: 'Category Added' }
        format.json { render :show, status: :created, location: @category}

      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }

      end
    end
  end

  def update

    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to edit_shop_registration_path, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

def set_category
  @category = Category.find(params[:id])
end

def category_params
  params.require(:category).permit(:category_name)
end

end
