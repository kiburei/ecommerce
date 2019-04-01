class OrdersController < ApplicationController
  before_action :current_cart, only: [:create, :reset_cart]

  def create
    @order = Shop.last.orders.create(order_subtotal: @cart.sub_total_price, order_total: @cart.total_price, order_items_count: @cart.order_items.count, order_status: 'In Progress')
    @order.update(order_params)
    @cart.order_items.each do |order_item|
      @order.order_items.create!(quantity: order_item.attributes["quantity"], product_id: order_item.attributes["product_id"], size: order_item["size"], total_cost: order_item.attributes["total_cost"])
    end
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
