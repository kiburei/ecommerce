class ShoppingCartController < ApplicationController
  before_action :set_cart, only: [:add_to_cart, :remove_from_cart, :add_item, :minus_item]
  before_action :set_order_item, only: [:remove_from_cart, :add_item, :minus_item]

  def add_to_cart

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

  def remove_from_cart
    @order_item.delete
    ShoppingCart.update_cart(@cart, current_shop)
  end

  def add_item
    qty = @order_item.quantity.to_i + 1
    total_cost = qty * @order_item.product.price
    @order_item.update(quantity: qty, total_cost: total_cost)
    ShoppingCart.update_cart(@cart, current_shop)
  end

  def minus_item
    qty = @order_item.quantity.to_i - 1
    if qty < 1
      remove_from_cart
    else
      total_cost = qty * @order_item.product.price
      @order_item.update(quantity: qty, total_cost: total_cost)
      ShoppingCart.update_cart(@cart, current_shop)
    end
  end

  private

  def order_item_params
    params.permit(:quantity, :product_id, :size)
  end

  def set_cart
    @cart = ShoppingCart.find_by_session_id(session.id)
  end

  def set_order_item
    @order_item = OrderItem.find(params[:order_item_id])
  end

end
