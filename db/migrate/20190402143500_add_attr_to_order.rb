class AddAttrToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment_status, :string, :default => "Unpaid"
  end
end
