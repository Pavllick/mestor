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

ActiveRecord::Schema.define(version: 20180209062127) do

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

  create_table "instances", force: :cascade do |t|
    t.string "serial_number"
    t.string "note"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_instances_on_device_id"
  end

  create_table "measurements", force: :cascade do |t|
    t.string "identifier"
    t.integer "value"
    t.bigint "instance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instance_id"], name: "index_measurements_on_instance_id"
  end

end
