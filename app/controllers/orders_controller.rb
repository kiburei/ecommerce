class OrdersController < ApplicationController
  before_action :current_cart, only: [:create, :reset_cart]

  def create
    @order = Shop.last.orders.create(order_subtotal: @cart.sub_total_price, order_total: @cart.total_price, order_items_count: @cart.order_items.count, order_status: 'In Progress')
    @order.update(order_params)
    # Empty Cart/Create new
    reset_cart
    redirect_to root_url
  end

  def reset_cart
    puts @cart.order_items
    @cart.order_items.delete_all
    ShoppingCart.update_cart(@cart, current_shop)
  end

  private

  def order_params
    params.permit(:client_name, :client_phone_number, :delivery, :order_payment_method)
  end

end
