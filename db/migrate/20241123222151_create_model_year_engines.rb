class CreateModelYearEngines < ActiveRecord::Migration[7.2]
  def change
    create_table :model_year_engines do |t|
      t.references :model_year, null: false, foreign_key: true
      t.references :engine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
