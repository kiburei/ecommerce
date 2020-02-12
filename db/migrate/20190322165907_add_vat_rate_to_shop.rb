class AddVatRateToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :vat_rate, :decimal
  end
end
