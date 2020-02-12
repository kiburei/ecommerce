class AddShopToCategories < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :shop, foreign_key: true
  end
end
