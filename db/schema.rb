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

ActiveRecord::Schema.define(version: 20141026145529) do

  create_table "images", force: true do |t|
    t.string   "image"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images_nodes", id: false, force: true do |t|
    t.integer "image_id", null: false
    t.integer "node_id",  null: false
  end

  add_index "images_nodes", ["image_id", "node_id"], name: "index_images_nodes_on_image_id_and_node_id"
  add_index "images_nodes", ["node_id", "image_id"], name: "index_images_nodes_on_node_id_and_image_id"

  create_table "node_images", force: true do |t|
    t.integer  "node_id"
    t.integer  "image_id"
    t.integer  "position",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "node_images", ["image_id"], name: "index_node_images_on_image_id"
  add_index "node_images", ["node_id", "position"], name: "index_node_images_on_node_id_and_position"

  create_table "nodes", force: true do |t|
    t.string   "title"
    t.text     "tldr"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  add_index "nodes", ["status"], name: "index_nodes_on_status"

end
