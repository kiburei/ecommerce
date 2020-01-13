class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :physical_address
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
