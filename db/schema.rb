# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_22_165907) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "country"
    t.string "physical_address"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "shop_id"
    t.index ["shop_id"], name: "index_addresses_on_shop_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "shop_id"
    t.index ["shop_id"], name: "index_categories_on_shop_id"
  end

  create_table "order_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.bigint "shopping_cart_id"
    t.string "size"
    t.decimal "total_cost", precision: 10
    t.index ["product_id"], name: "index_order_items_on_product_id"
    t.index ["shopping_cart_id"], name: "index_order_items_on_shopping_cart_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_name"
    t.string "product_description"
    t.decimal "price", precision: 10
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.bigint "shop_id"
    t.integer "rating"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "shopping_carts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "sub_total_price", precision: 10
    t.decimal "total_price", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
  end

  create_table "shops", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "shop_name"
    t.string "tag_line"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "vat_rate", precision: 10
    t.index ["email"], name: "index_shops_on_email", unique: true
    t.index ["reset_password_token"], name: "index_shops_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "shops"
  add_foreign_key "categories", "shops"
  add_foreign_key "order_items", "products"
  add_foreign_key "order_items", "shopping_carts"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "shops"
end
