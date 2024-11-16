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

ActiveRecord::Schema[7.2].define(version: 2024_11_16_074732) do
  create_table "brand_products", force: :cascade do |t|
    t.integer "brand_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_products_on_brand_id"
    t.index ["product_id"], name: "index_brand_products_on_product_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_products", force: :cascade do |t|
    t.integer "car_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_car_products_on_car_id"
    t.index ["product_id"], name: "index_car_products_on_product_id"
  end

  create_table "cars", force: :cascade do |t|
    t.integer "brand_id", null: false
    t.integer "model_id", null: false
    t.integer "year_id", null: false
    t.integer "engine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_cars_on_brand_id"
    t.index ["engine_id"], name: "index_cars_on_engine_id"
    t.index ["model_id"], name: "index_cars_on_model_id"
    t.index ["year_id"], name: "index_cars_on_year_id"
  end

  create_table "characteristics", force: :cascade do |t|
    t.string "name", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engine_products", force: :cascade do |t|
    t.integer "engine_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engine_id"], name: "index_engine_products_on_engine_id"
    t.index ["product_id"], name: "index_engine_products_on_product_id"
  end

  create_table "engines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "model_products", force: :cascade do |t|
    t.integer "model_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_model_products_on_model_id"
    t.index ["product_id"], name: "index_model_products_on_product_id"
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
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.decimal "price"
    t.integer "stock"
    t.integer "part_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id"], name: "index_products_on_part_id"
  end

  create_table "years", force: :cascade do |t|
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "brand_products", "brands"
  add_foreign_key "brand_products", "products"
  add_foreign_key "car_products", "cars"
  add_foreign_key "car_products", "products"
  add_foreign_key "cars", "brands"
  add_foreign_key "cars", "engines"
  add_foreign_key "cars", "models"
  add_foreign_key "cars", "years"
  add_foreign_key "engine_products", "engines"
  add_foreign_key "engine_products", "products"
  add_foreign_key "model_products", "models"
  add_foreign_key "model_products", "products"
  add_foreign_key "models", "brands"
  add_foreign_key "part_characteristics", "characteristics"
  add_foreign_key "part_characteristics", "parts"
  add_foreign_key "products", "parts"
end
