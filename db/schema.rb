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

ActiveRecord::Schema.define(version: 2019_11_16_223553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignations", force: :cascade do |t|
    t.bigint "route_id"
    t.bigint "driver_id"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_assignations_on_driver_id"
    t.index ["route_id"], name: "index_assignations_on_route_id"
    t.index ["vehicle_id"], name: "index_assignations_on_vehicle_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.integer "phone"
    t.string "email"
    t.text "cities"
    t.integer "max_number_of_stops"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id"
    t.datetime "available_at"
    t.index ["vehicle_id"], name: "index_drivers_on_vehicle_id"
  end

  create_table "routes", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "load_type"
    t.text "cities"
    t.integer "stops_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id"
    t.bigint "driver_id"
    t.integer "load_sum"
    t.index ["driver_id"], name: "index_routes_on_driver_id"
    t.index ["vehicle_id"], name: "index_routes_on_vehicle_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "load_type"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "driver_id"
    t.datetime "available_at"
    t.string "name"
    t.index ["driver_id"], name: "index_vehicles_on_driver_id"
  end

  add_foreign_key "assignations", "drivers"
  add_foreign_key "assignations", "routes"
  add_foreign_key "assignations", "vehicles"
  add_foreign_key "drivers", "vehicles"
  add_foreign_key "routes", "drivers"
  add_foreign_key "routes", "vehicles"
  add_foreign_key "vehicles", "drivers"
end
