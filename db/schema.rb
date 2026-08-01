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

ActiveRecord::Schema[8.1].define(version: 2026_07_30_012146) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "base_pizzas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "pizza_category_id"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "slug", null: false
    t.index ["pizza_category_id"], name: "index_base_pizzas_on_pizza_category_id"
  end

  create_table "cart_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "cart_itemable_id"
    t.string "cart_itemable_type"
    t.integer "quantity", default: 1, null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["cart_itemable_type", "cart_itemable_id"], name: "index_cart_items_on_cart_itemable"
  end

  create_table "carts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "pizza_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.index ["slug"], name: "index_pizza_categories_on_slug", unique: true
  end

  create_table "pizza_ingredients", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pizza_id"
    t.bigint "pizza_topping_id"
    t.integer "quantity", default: 1, null: false
    t.index ["pizza_id", "pizza_topping_id"], name: "index_pizza_ingredients_on_pizza_id_and_pizza_topping_id", unique: true
    t.index ["pizza_id"], name: "index_pizza_ingredients_on_pizza_id"
    t.index ["pizza_topping_id"], name: "index_pizza_ingredients_on_pizza_topping_id"
  end

  create_table "pizza_toppings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "in_catalog", default: true, null: false
    t.boolean "is_base", default: false, null: false
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "slug", null: false
    t.index ["slug"], name: "index_pizza_toppings_on_slug", unique: true
  end

  create_table "pizzas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "base_pizza_id"
    t.string "crust", null: false
    t.string "dough", null: false
    t.string "fingerprint", null: false
    t.boolean "in_catalog", default: true, null: false
    t.boolean "is_base", default: false, null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "size", null: false
    t.index ["base_pizza_id"], name: "index_pizzas_on_base_pizza_id"
    t.index ["fingerprint"], name: "index_pizzas_on_fingerprint", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "base_pizzas", "pizza_categories"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "carts", "users"
  add_foreign_key "pizza_ingredients", "pizza_toppings"
  add_foreign_key "pizza_ingredients", "pizzas"
  add_foreign_key "pizzas", "base_pizzas"
end
