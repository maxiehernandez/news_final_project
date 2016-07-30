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

ActiveRecord::Schema.define(version: 20160729182636) do

  create_table "editors", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "stories", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "editor_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.string   "tweeters_id"
    t.string   "tweet_id"
    t.integer  "favorites"
    t.integer  "retweets"
    t.integer  "story_id"
    t.string   "text"
    t.string   "hashtags"
    t.string   "mentions"
    t.text     "urls"
    t.integer  "followers"
    t.string   "screen_name"
    t.integer  "friends"
    t.integer  "rank"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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

end
