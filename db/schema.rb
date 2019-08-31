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

ActiveRecord::Schema.define(version: 2019_08_09_183357) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "shortname"
    t.string "color"
    t.string "desc"
    t.string "location"
    t.string "country", default: "un", null: false
    t.integer "prize"
    t.date "start_date"
    t.date "end_date"
    t.boolean "display_ranking", default: false, null: false
    t.boolean "primary_ranking", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eventteams", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_eventteams_on_event_id"
    t.index ["team_id"], name: "index_eventteams_on_team_id"
  end

  create_table "forum_posts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "commentable_id"
    t.integer "score", default: 0, null: false
    t.string "commentable_type"
    t.integer "thread_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forum_threads", force: :cascade do |t|
    t.integer "user_id"
    t.text "subject"
    t.text "description"
    t.integer "comments_count", default: 0, null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maps", force: :cascade do |t|
    t.integer "official_id"
    t.integer "winner_id"
    t.string "score"
    t.string "name"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["official_id"], name: "index_maps_on_official_id"
    t.index ["winner_id"], name: "index_maps_on_winner_id"
  end

  create_table "news", force: :cascade do |t|
    t.json "pictures"
    t.integer "user_id"
    t.string "country", default: "un", null: false
    t.text "subject"
    t.text "article"
    t.integer "comments_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_news_on_user_id"
  end

  create_table "officials", force: :cascade do |t|
    t.integer "team1_id"
    t.integer "team2_id"
    t.integer "winner_id"
    t.integer "identifier"
    t.integer "comments_count", default: 0, null: false
    t.integer "map_count", default: 5, null: false
    t.string "label"
    t.string "score"
    t.string "match_type"
    t.datetime "start"
    t.datetime "end"
    t.integer "section_id"
    t.integer "event_id"
    t.string "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_officials_on_event_id"
    t.index ["section_id"], name: "index_officials_on_section_id"
    t.index ["team1_id"], name: "index_officials_on_team1_id"
    t.index ["team2_id"], name: "index_officials_on_team2_id"
    t.index ["winner_id"], name: "index_officials_on_winner_id"
  end

  create_table "performances", force: :cascade do |t|
    t.integer "player_id"
    t.integer "map_id"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_performances_on_map_id"
    t.index ["player_id"], name: "index_performances_on_player_id"
    t.index ["team_id"], name: "index_performances_on_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "headshot"
    t.string "eng_name"
    t.string "nat_name"
    t.string "nicknames"
    t.string "handle"
    t.string "country", default: "un", null: false
    t.date "birthday"
    t.string "roles"
    t.string "socials"
    t.boolean "starter", default: false, null: false
    t.integer "team_id"
    t.integer "past_teams"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "event_id"
    t.string "name"
    t.date "start"
    t.date "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_sections_on_event_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "shortname"
    t.string "logo"
    t.string "country", default: "un", null: false
    t.string "socials"
    t.string "website"
    t.integer "winnings", default: 0, null: false
    t.integer "rating", default: 1500, null: false
    t.integer "streak", default: 0, null: false
    t.integer "games_played", default: 0, null: false
    t.datetime "last_played"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "votable_id"
    t.string "votable_type"
    t.integer "direction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

end
