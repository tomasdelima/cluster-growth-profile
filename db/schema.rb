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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160531183747) do

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "clusters", force: :cascade do |t|
    t.string   "name"
    t.string   "growth_stage"
    t.string   "counsil_name"
    t.string   "abm_names"
    t.integer  "cabc_count"
    t.integer  "cce_count"
    t.integer  "cgpj_count"
    t.integer  "cia_count"
    t.integer  "geographic_size"
    t.integer  "lsa_count"
    t.integer  "population_size"
    t.integer  "sites_with_believers_count"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "growth_profiles", force: :cascade do |t|
    t.string   "cycle"
    t.integer  "cluster_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "book1"
    t.integer  "book2"
    t.integer  "book3grade1"
    t.integer  "book3grade2"
    t.integer  "book3grade3"
    t.integer  "book4"
    t.integer  "book5"
    t.integer  "book6"
    t.integer  "book7"
    t.integer  "book8"
  end

  add_index "growth_profiles", ["cluster_id"], name: "index_growth_profiles_on_cluster_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
