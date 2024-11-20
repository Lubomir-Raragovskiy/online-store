class AddAddressToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :address_id, :integer
  end
end
