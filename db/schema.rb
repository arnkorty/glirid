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

ActiveRecord::Schema.define(version: 20150915070126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "zhparser"
  enable_extension "scws_parser"

  create_table "accounts", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.string   "rss_token"
    t.datetime "deleted_at"
  end

  add_index "accounts", ["deleted_at"], name: "index_accounts_on_deleted_at", using: :btree
  add_index "accounts", ["email"], name: "index_accounts_on_email", using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree

  create_table "feed_url_searches", force: :cascade do |t|
    t.integer  "feed_url_id"
    t.integer  "search_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "feed_url_searches", ["feed_url_id"], name: "index_feed_url_searches_on_feed_url_id", using: :btree
  add_index "feed_url_searches", ["search_id"], name: "index_feed_url_searches_on_search_id", using: :btree

  create_table "feed_urls", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "account_id"
    t.string   "token"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_open",     default: true
    t.integer  "collect_num"
    t.integer  "limit",       default: 100
  end

  add_index "feed_urls", ["account_id"], name: "index_feed_urls_on_account_id", using: :btree

  create_table "feed_urls_searches", force: :cascade do |t|
    t.integer  "feed_url_id"
    t.integer  "search_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "feed_urls_searches", ["feed_url_id"], name: "index_feed_urls_searches_on_feed_url_id", using: :btree
  add_index "feed_urls_searches", ["search_id"], name: "index_feed_urls_searches_on_search_id", using: :btree

  create_table "frequencies", force: :cascade do |t|
    t.string   "name"
    t.integer  "frequency_time"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "results", force: :cascade do |t|
    t.integer  "search_id"
    t.integer  "account_id"
    t.string   "title"
    t.string   "url"
    t.string   "domain"
    t.text     "description"
    t.datetime "task_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
  end

  add_index "results", ["account_id"], name: "index_results_on_account_id", using: :btree
  add_index "results", ["deleted_at"], name: "index_results_on_deleted_at", using: :btree
  add_index "results", ["search_id"], name: "index_results_on_search_id", using: :btree

  create_table "rss_feed_searches", force: :cascade do |t|
    t.integer  "rss_feed_id"
    t.integer  "search_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rss_feed_searches", ["rss_feed_id"], name: "index_rss_feed_searches_on_rss_feed_id", using: :btree
  add_index "rss_feed_searches", ["search_id"], name: "index_rss_feed_searches_on_search_id", using: :btree

  create_table "rss_feeds", force: :cascade do |t|
    t.string   "name"
    t.integer  "limit"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "account_id"
    t.text     "description"
  end

  add_index "rss_feeds", ["account_id"], name: "index_rss_feeds_on_account_id", using: :btree

  create_table "search_tasks", force: :cascade do |t|
    t.integer  "search_id"
    t.datetime "begin_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "frequency_id"
    t.string   "name"
    t.string   "job_id"
  end

  add_index "search_tasks", ["frequency_id"], name: "index_search_tasks_on_frequency_id", using: :btree
  add_index "search_tasks", ["search_id"], name: "index_search_tasks_on_search_id", using: :btree

  create_table "searches", force: :cascade do |t|
    t.string   "provider"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "account_id"
    t.string   "name"
    t.text     "description"
    t.json     "options",         default: {}
    t.string   "current_work_id"
    t.string   "next_work_id"
    t.datetime "next_at"
    t.datetime "last_at"
    t.datetime "deleted_at"
  end

  add_index "searches", ["account_id"], name: "index_searches_on_account_id", using: :btree
  add_index "searches", ["deleted_at"], name: "index_searches_on_deleted_at", using: :btree

  add_foreign_key "feed_url_searches", "feed_urls"
  add_foreign_key "feed_url_searches", "searches"
  add_foreign_key "feed_urls", "accounts"
  add_foreign_key "feed_urls_searches", "feed_urls"
  add_foreign_key "feed_urls_searches", "searches"
  add_foreign_key "results", "accounts"
  add_foreign_key "results", "searches"
  add_foreign_key "rss_feed_searches", "rss_feeds"
  add_foreign_key "rss_feed_searches", "searches"
  add_foreign_key "rss_feeds", "accounts"
  add_foreign_key "search_tasks", "frequencies"
  add_foreign_key "search_tasks", "searches"
  add_foreign_key "searches", "accounts"
end
