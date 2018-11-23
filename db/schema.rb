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

ActiveRecord::Schema.define(version: 2018_11_23_115321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "available_pumping_units", force: :cascade do |t|
    t.float "Max_GR"
    t.float "PPRL"
    t.float "Max_Stroke_Length"
    t.float "Stroke_lengths_1"
    t.float "Stroke_lengths_3"
    t.float "Stroke_lengths_2"
    t.float "Stroke_lengths_4"
    t.float "cost"
  end

  create_table "available_sucker_rod_pump_sizes", force: :cascade do |t|
    t.float "Plunger_Diameter"
    t.float "Plunger_Area"
    t.float "Barrel_OD"
    t.float "min_Tubing_size"
    t.float "max_Tubing_size"
  end

  create_table "barrel_sizes", force: :cascade do |t|
    t.float "size"
  end

  create_table "choices", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "property_id"
    t.index ["property_id"], name: "index_choices_on_property_id"
  end

  create_table "nemas", force: :cascade do |t|
    t.float "motor_hp"
    t.float "cost1"
    t.float "cost2"
    t.float "cost3"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tab_id"
    t.string "description"
    t.integer "choice_type"
    t.text "note"
    t.integer "unit_type"
    t.index ["tab_id"], name: "index_properties_on_tab_id"
  end

  create_table "pump_properties", force: :cascade do |t|
    t.bigint "pump_id"
    t.bigint "property_id"
    t.bigint "choice_id"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_id"], name: "index_pump_properties_on_choice_id"
    t.index ["property_id"], name: "index_pump_properties_on_property_id"
    t.index ["pump_id"], name: "index_pump_properties_on_pump_id"
  end

  create_table "pumps", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rod_string_tapering_percentages", force: :cascade do |t|
    t.float "Rod"
    t.float "plunger_Diameter"
    t.float "Rod_Weight"
    t.float "size_118"
    t.float "size_1"
    t.float "size"
    t.float "_78"
    t.float "size_34"
  end

  create_table "sucker_rods", force: :cascade do |t|
    t.string "api"
    t.string "Weatherford"
    t.float "yield_strength"
    t.string "corrosion_resistance"
  end

  create_table "tabs", force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "choices", "properties"
  add_foreign_key "properties", "tabs"
end
