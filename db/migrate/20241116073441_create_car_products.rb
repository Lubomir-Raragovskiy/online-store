class CreateCarProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :car_products do |t|
      t.references :car, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
