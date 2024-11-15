# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_15_200251) do
  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characteristics", force: :cascade do |t|
    t.string "name", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engines", force: :cascade do |t|
    t.string "name"
    t.integer "model_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_engines_on_model_id"
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.integer "brand_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_models_on_brand_id"
  end

  create_table "part_characteristics", force: :cascade do |t|
    t.integer "part_id", null: false
    t.integer "characteristic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["characteristic_id"], name: "index_part_characteristics_on_characteristic_id"
    t.index ["part_id"], name: "index_part_characteristics_on_part_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "name"
    t.integer "characteristics_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["characteristics_id"], name: "index_parts_on_characteristics_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "image"
    t.decimal "price", precision: 10, scale: 2
    t.integer "stock", default: 0
    t.integer "part_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id"], name: "index_products_on_part_id"
  end

  create_table "years", force: :cascade do |t|
    t.integer "model_id", null: false
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_years_on_model_id"
  end

  add_foreign_key "engines", "models"
  add_foreign_key "models", "brands"
  add_foreign_key "part_characteristics", "characteristics"
  add_foreign_key "part_characteristics", "parts"
  add_foreign_key "parts", "characteristics", column: "characteristics_id"
  add_foreign_key "products", "parts"
  add_foreign_key "years", "models"
end
