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

ActiveRecord::Schema.define(version: 2018_07_28_120859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_youtube_videos", force: :cascade do |t|
    t.integer "user_id"
    t.integer "youtube_video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_youtube_videos_on_user_id"
    t.index ["youtube_video_id"], name: "index_user_youtube_videos_on_youtube_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "uid"
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_bot", default: false, null: false
    t.boolean "has_blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language"
  end

  create_table "youtube_videos", force: :cascade do |t|
    t.string "youtube_id"
    t.string "channel_id"
    t.string "channel_name"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
