class OrderItemsController < ApplicationController

  def create
    @cart = ShoppingCart.find_by_session_id(session.id)
    @order_item = @cart.order_items.build(order_item_params)
    puts @order_item
    if @order_item.save
      redirect_to product_path(order_item_params[:product_id])
    end
  end

  private

  def order_item_params
    params.permit(:quantity, :product_id, :size)
  end

end
