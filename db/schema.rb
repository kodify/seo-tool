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

ActiveRecord::Schema.define(version: 20131011103057) do

  create_table "domains", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", force: true do |t|
    t.integer  "url_id"
    t.integer  "site_id"
    t.string   "link"
    t.string   "anchor"
    t.string   "status"
    t.string   "affiliate"
    t.string   "campaign"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["site_id"], name: "index_links_on_site_id", using: :btree
  add_index "links", ["url_id"], name: "index_links_on_url_id", using: :btree

  create_table "sites", force: true do |t|
    t.string   "code"
    t.string   "domain"
    t.string   "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", force: true do |t|
    t.integer  "site_id"
    t.integer  "url_id"
    t.string   "internal_links"
    t.string   "external_links"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stats", ["site_id"], name: "index_stats_on_site_id", using: :btree
  add_index "stats", ["url_id"], name: "index_stats_on_url_id", using: :btree

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "urls", force: true do |t|
    t.integer  "status_id"
    t.string   "url"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at"
    t.integer  "internal_links",   default: 0
    t.integer  "external_links",   default: 0
    t.datetime "visited_at"
    t.string   "ip"
    t.string   "subdomain"
    t.string   "domain_authority"
    t.string   "page_authority"
    t.integer  "domain_id"
  end

  add_index "urls", ["domain_id"], name: "index_urls_on_domain_id", using: :btree
  add_index "urls", ["status_id"], name: "index_urls_on_status_id", using: :btree

end
