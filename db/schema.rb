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

<<<<<<< HEAD
ActiveRecord::Schema[7.2].define(version: 2024_11_16_074732) do
=======
ActiveRecord::Schema[7.2].define(version: 2024_11_19_190327) do
>>>>>>> 828d59f (Added cart and order pages, created users and orders tables in db)
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

<<<<<<< HEAD
=======
  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

>>>>>>> 828d59f (Added cart and order pages, created users and orders tables in db)
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

<<<<<<< HEAD
=======
  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

>>>>>>> 828d59f (Added cart and order pages, created users and orders tables in db)
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
<<<<<<< HEAD
=======
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "users"
>>>>>>> 828d59f (Added cart and order pages, created users and orders tables in db)
  add_foreign_key "part_characteristics", "characteristics"
  add_foreign_key "part_characteristics", "parts"
  add_foreign_key "products", "parts"
end
