class CreateYears < ActiveRecord::Migration[7.2]
  def change
    create_table :years do |t|
      t.references :model, null: false, foreign_key: true
      t.integer :year

      t.timestamps
    end
  end
end
