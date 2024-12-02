class UpdateAddressesTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :addresses

    create_table :addresses do |t|
      t.string :line1
      t.string :line2
      t.string :city
      t.string :district
      t.string :region
      t.string :postal_code

      t.timestamps
    end
  end
end