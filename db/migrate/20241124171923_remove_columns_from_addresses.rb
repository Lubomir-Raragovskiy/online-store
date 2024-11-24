class RemoveColumnsFromAddresses < ActiveRecord::Migration[7.2]
  def change
    remove_column :addresses, :line1, :string
    remove_column :addresses, :line2, :string
    remove_column :addresses, :city, :string
    remove_column :addresses, :postal_code, :string
  end
end
