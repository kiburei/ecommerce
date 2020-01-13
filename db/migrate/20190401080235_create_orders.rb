class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :order_subtotal
      t.decimal :order_total
      t.integer :order_items_count
      t.string :order_status
      t.string :order_payment_method

      t.timestamps
    end
  end
end
