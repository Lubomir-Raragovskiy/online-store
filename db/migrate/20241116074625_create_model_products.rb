class CreateModelProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :model_products do |t|
      t.references :model, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end