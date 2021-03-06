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

ActiveRecord::Schema.define(version: 20170620062215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_movies", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "movie_id",    null: false
  end

  add_index "categories_movies", ["category_id", "movie_id"], name: "index_categories_movies_on_category_id_and_movie_id", using: :btree
  add_index "categories_movies", ["movie_id", "category_id"], name: "index_categories_movies_on_movie_id_and_category_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "movie_id"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["movie_id"], name: "index_comments_on_movie_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "picture"
  end

  add_index "movies", ["user_id"], name: "index_movies_on_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "stars",      default: 3
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "ratings", ["movie_id"], name: "index_ratings_on_movie_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "api_key"
  end

  add_index "users", ["api_key"], name: "index_users_on_api_key", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comments", "movies"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "movies", "users"
  add_foreign_key "ratings", "movies"
  add_foreign_key "ratings", "users"
end
