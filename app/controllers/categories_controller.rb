class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def show
    @products = @category.products
  end

  def create
    @category = current_shop.categories.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to edit_shop_registration_path, notice: 'Category Added' }
      else
        format.html { render :new }
      end
    end
  end

private

def category_params
  params.permit(:category_name)
end

def set_category
  @category = Category.find(params[:id])
end

end
