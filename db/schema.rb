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

ActiveRecord::Schema.define(version: 2019_06_26_230227) do

  create_table "compositions", force: :cascade do |t|
    t.string "player_roster"
    t.string "hero_roster"
    t.string "roundtype"
    t.integer "duration"
    t.integer "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_compositions_on_match_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.string "location"
    t.string "country", default: "un", null: false
    t.integer "prize"
    t.date "start_date"
    t.date "end_date"
  end

  create_table "eventteams", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_eventteams_on_event_id"
    t.index ["team_id"], name: "index_eventteams_on_team_id"
  end

  create_table "fights", force: :cascade do |t|
    t.string "roundtype"
    t.integer "duration"
    t.string "left_players"
    t.string "left_heroes"
    t.string "right_players"
    t.string "right_heroes"
    t.string "winner"
    t.string "first_blood"
    t.integer "left_kill_num"
    t.integer "right_kill_num"
    t.integer "left_ults_used"
    t.integer "right_ults_used"
    t.string "left_ult_sequence"
    t.string "right_ult_sequence"
    t.string "total_kill_sequence"
    t.string "total_death_sequence"
    t.integer "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_fights_on_match_id"
  end

  create_table "forum_posts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "commentable_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "generals", force: :cascade do |t|
    t.string "player"
    t.string "hero"
    t.integer "kill"
    t.integer "death"
    t.string "ttcu"
    t.string "ttuu"
    t.integer "fight_total"
    t.integer "fight_win"
    t.integer "fight_lose"
    t.integer "first_kill"
    t.integer "first_death"
    t.integer "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_generals_on_match_id"
  end

  create_table "maps", force: :cascade do |t|
    t.integer "official_id"
    t.integer "winner_id"
    t.string "score"
    t.string "name"
    t.string "state"
    t.index ["official_id"], name: "index_maps_on_official_id"
    t.index ["winner_id"], name: "index_maps_on_winner_id"
  end

  create_table "matches", force: :cascade do |t|
    t.date "date"
    t.string "left_team"
    t.string "right_team"
    t.string "map"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "news", force: :cascade do |t|
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

  create_table "performances", id: false, force: :cascade do |t|
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
    t.integer "age"
    t.string "roles"
    t.string "socials"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "event_id"
    t.string "name"
    t.date "start"
    t.date "end"
    t.index ["event_id"], name: "index_sections_on_event_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "shortname"
    t.string "logo"
    t.string "country", default: "un", null: false
    t.string "socials"
    t.string "website"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
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

end
