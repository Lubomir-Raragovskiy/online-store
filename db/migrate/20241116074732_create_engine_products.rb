class CreateEngineProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :engine_products do |t|
      t.references :engine, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
