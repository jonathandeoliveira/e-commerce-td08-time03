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

ActiveRecord::Schema[7.0].define(version: 2022_06_27_233351) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "registration_number"
    t.string "full_adress"
    t.decimal "balance", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "merchants", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_merchants_on_email", unique: true
    t.index ["reset_password_token"], name: "index_merchants_on_reset_password_token", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.string "code"
    t.decimal "total_value"
    t.integer "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "address"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "product_items", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "product_model_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["customer_id"], name: "index_product_items_on_customer_id"
    t.index ["order_id"], name: "index_product_items_on_order_id"
    t.index ["product_model_id"], name: "index_product_items_on_product_model_id"
  end

  create_table "product_models", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.string "sku"
    t.string "model"
    t.boolean "fragile", default: false
    t.string "description"
    t.float "weight"
    t.float "height"
    t.float "width"
    t.float "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 10
    t.integer "sub_category_id", null: false
    t.index ["sub_category_id"], name: "index_product_models_on_sub_category_id"
  end

  create_table "product_prices", force: :cascade do |t|
    t.decimal "price"
    t.date "start_date"
    t.date "end_date"
    t.integer "product_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_model_id"], name: "index_product_prices_on_product_model_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 10
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "orders", "customers"
  add_foreign_key "product_items", "customers"
  add_foreign_key "product_items", "orders"
  add_foreign_key "product_items", "product_models"
  add_foreign_key "product_models", "sub_categories"
  add_foreign_key "product_prices", "product_models"
  add_foreign_key "sub_categories", "categories"
end
