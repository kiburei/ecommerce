class CreateShoppingCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_carts do |t|
      t.decimal :sub_total_price
      t.decimal :total_price

      t.timestamps
    end
  end
end
