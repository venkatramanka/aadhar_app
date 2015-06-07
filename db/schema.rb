# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150606150304) do

  create_table "store_categories", :force => true do |t|
    t.string   "name"
    t.float    "tax_percent"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "store_transactions", :force => true do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "store_id"
    t.float    "tax"
    t.text     "remarks"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "line_1"
    t.string   "line_2"
    t.string   "city"
    t.string   "state"
    t.integer  "pincode"
    t.string   "phone"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "verified"
  end

  create_table "user_transactions", :force => true do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "to_user_id"
    t.text     "remarks"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "aadhar_number"
    t.string   "name"
    t.string   "gender"
    t.date     "dob"
    t.text     "address"
    t.string   "mobile_number"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "wallets", :force => true do |t|
    t.integer  "owner_id"
    t.string   "type"
    t.float    "balance"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
