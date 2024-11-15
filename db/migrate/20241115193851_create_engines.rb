class CreateEngines < ActiveRecord::Migration[7.2]
  def change
    create_table :engines do |t|
      t.string :name
      t.references :model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
