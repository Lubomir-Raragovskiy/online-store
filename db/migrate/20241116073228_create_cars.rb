class CreateCars < ActiveRecord::Migration[7.2]
  def change
    create_table :cars do |t|
      t.references :brand, null: false, foreign_key: true
      t.references :model, null: false, foreign_key: true
      t.references :year, null: false, foreign_key: true
      t.references :engine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
