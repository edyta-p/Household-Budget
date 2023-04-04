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

ActiveRecord::Schema[7.0].define(version: 2023_04_04_145524) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_purchase"
    t.string "shop_name"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_apartments_on_user_id"
  end

  create_table "beauties", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_purchase"
    t.string "shop_name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_beauties_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_purchase"
    t.string "shop_name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "clothings", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_purchase"
    t.string "shop_name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clothings_on_user_id"
  end

  create_table "entertainments", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_purchase"
    t.string "shop_name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_entertainments_on_user_id"
  end

  create_table "healths", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_purchase"
    t.string "shop_name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_healths_on_user_id"
  end

  create_table "kids", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_purchase"
    t.string "shop_name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_kids_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_purchase"
    t.string "shop_name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "mobiles", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_purchase"
    t.string "shop_name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mobiles_on_user_id"
  end

  create_table "others", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_purchase"
    t.string "shop_name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_others_on_user_id"
  end

  create_table "repayments", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_transaction"
    t.string "lender"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_repayments_on_user_id"
  end

  create_table "savings", force: :cascade do |t|
    t.string "category"
    t.float "amount"
    t.string "currency", default: "€", null: false
    t.datetime "date_of_transaction"
    t.string "placement"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_savings_on_user_id"
  end

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

  add_foreign_key "apartments", "users"
  add_foreign_key "beauties", "users"
  add_foreign_key "cars", "users"
  add_foreign_key "clothings", "users"
  add_foreign_key "entertainments", "users"
  add_foreign_key "healths", "users"
  add_foreign_key "kids", "users"
  add_foreign_key "meals", "users"
  add_foreign_key "mobiles", "users"
  add_foreign_key "others", "users"
  add_foreign_key "repayments", "users"
  add_foreign_key "savings", "users"
end
