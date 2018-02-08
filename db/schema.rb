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

ActiveRecord::Schema.define(version: 20180206074610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analog_params", force: :cascade do |t|
    t.string "identifier"
    t.string "name"
    t.string "unit"
    t.integer "upper_range_limit"
    t.integer "lower_range_limit"
    t.boolean "active"
    t.bigint "device_id"
    t.index ["device_id"], name: "index_analog_params_on_device_id"
  end

  create_table "arbitrary_params", force: :cascade do |t|
    t.string "identifier"
    t.string "name"
    t.boolean "active"
    t.bigint "device_id"
    t.index ["device_id"], name: "index_arbitrary_params_on_device_id"
  end

  create_table "authorized_devices", force: :cascade do |t|
    t.string "mi_type_sign"
    t.string "serial_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "mi_name"
    t.string "mi_type_sign"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discrete_params", force: :cascade do |t|
    t.string "identifier"
    t.string "name"
    t.boolean "active"
    t.bigint "device_id"
    t.index ["device_id"], name: "index_discrete_params_on_device_id"
  end

  create_table "sensor_measurements", force: :cascade do |t|
    t.integer "value"
    t.bigint "users_sensor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_sensor_id"], name: "index_sensor_measurements_on_users_sensor_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.string "mi_name"
    t.string "mi_type_sign"
    t.string "unit"
    t.integer "upper_range_limit"
    t.integer "lower_range_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_sensors", force: :cascade do |t|
    t.string "serial_number"
    t.text "note"
    t.bigint "sensor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sensor_id"], name: "index_users_sensors_on_sensor_id"
  end

end
