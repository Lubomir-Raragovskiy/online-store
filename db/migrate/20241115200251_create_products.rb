class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.string :image
      t.decimal :price, precision: 10, scale: 2
      t.integer :stock, default: 0
      t.references :part, null: false, foreign_key: true

      t.timestamps
    end
  end
end
