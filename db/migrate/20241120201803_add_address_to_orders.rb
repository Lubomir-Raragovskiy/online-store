class AddAddressToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :address_id, :integer
  end
end