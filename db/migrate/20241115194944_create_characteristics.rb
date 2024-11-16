class CreateCharacteristics < ActiveRecord::Migration[7.2]
  def change
    create_table :characteristics do |t|
      t.string :name, null: false
      t.string :value

      t.timestamps
    end
  end
end
