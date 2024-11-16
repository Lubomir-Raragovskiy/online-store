class CreateBrandProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :brand_products do |t|
      t.references :brand, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
