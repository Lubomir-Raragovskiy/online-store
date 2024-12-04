class CreateCharacteristicValues < ActiveRecord::Migration[7.2]
  def change
    create_table :characteristic_values do |t|
      t.string :value
      t.references :characteristic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
