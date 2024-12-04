class CreateProductCharacteristicValues < ActiveRecord::Migration[7.2]
  def change
    create_table :product_characteristic_values do |t|
      t.references :product, null: false, foreign_key: true
      t.references :characteristic_value, null: false, foreign_key: true

      t.timestamps
    end
  end
end
