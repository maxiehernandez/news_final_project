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

ActiveRecord::Schema.define(version: 20160807170457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "news_rsses", force: :cascade do |t|
    t.string   "source_id"
    t.string   "source_name"
    t.date     "pub_date"
    t.string   "story_id"
    t.string   "headline"
    t.text     "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "summary"
    t.text     "keywords"
    t.text     "pic_url"
  end

  create_table "rss_feeds", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "soc_meds", force: :cascade do |t|
    t.string   "tweeters_id"
    t.string   "t_id"
    t.integer  "favorites"
    t.integer  "retweets"
    t.string   "text"
    t.string   "hashtags"
    t.string   "mentions"
    t.text     "urls"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "pub",         default: false
  end

  create_table "stories", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "topic_id"
    t.string   "story_type"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "editor_id"
    t.boolean  "pub_home",   default: false
    t.integer  "position"
    t.string   "slug"
    t.index ["slug"], name: "index_topics_on_slug", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "u_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.boolean  "admin"
    t.string   "last_name"
    t.string   "twitter_id"
    t.string   "facebook_id"
    t.string   "google_auth_token"
  end

  create_table "youtubes", force: :cascade do |t|
    t.string   "youtube_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "embed"
  end

end
