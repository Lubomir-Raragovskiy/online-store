class CreateModelYears < ActiveRecord::Migration[7.2]
  def change
    create_table :model_years do |t|
      t.references :model, null: false, foreign_key: true
      t.references :year, null: false, foreign_key: true

      t.timestamps
    end
  end
end
