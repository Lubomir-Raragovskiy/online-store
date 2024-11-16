class CreatePartCharacteristics < ActiveRecord::Migration[7.2]
  def change
    create_table :part_characteristics do |t|
      t.references :part, null: false, foreign_key: true
      t.references :characteristic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
