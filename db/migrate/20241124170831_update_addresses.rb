class UpdateAddresses < ActiveRecord::Migration[7.2]
  def change
    change_table :addresses do |t|
      t.string :settlement
      t.string :post_office
    end
  end
end
