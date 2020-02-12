class OrderItemsController < ApplicationController

  def create
    @cart = ShoppingCart.find_by_session_id(session.id)
    # check if order item exists
    if @cart.order_items.exists?(product_id: order_item_params[:product_id])
      @order_item = @cart.order_items.find_by_product_id(order_item_params[:product_id])
      qty = @order_item.quantity.to_i + order_item_params[:quantity].to_i
      total_cost = qty * @order_item.product.price
      @order_item.update(quantity: qty, total_cost: total_cost)
    else
      @order_item = @cart.order_items.build(order_item_params)
      @order_item.total_cost = @order_item.product.price * @order_item.quantity
      @order_item.save
    end
    ShoppingCart.update_cart(@cart, current_shop)
    redirect_to product_path(order_item_params[:product_id])

  end

  private

  def order_item_params
    params.permit(:quantity, :product_id, :size)
  end

end
