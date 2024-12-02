class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :line1
      t.string :line2
      t.string :city
      t.string :district
      t.string :region
      t.string :postal_code
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
