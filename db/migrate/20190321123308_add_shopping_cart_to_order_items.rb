class AddShoppingCartToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_items, :shopping_cart, foreign_key: true
  end
end
