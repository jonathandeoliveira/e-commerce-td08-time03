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

ActiveRecord::Schema[7.0].define(version: 2022_06_18_190255) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "product_models", "sub_categories"
  add_foreign_key "product_prices", "product_models"
  add_foreign_key "sub_categories", "categories"
end
