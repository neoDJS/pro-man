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

ActiveRecord::Schema.define(version: 2019_05_21_180120) do

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "priority"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_projects_on_created_by_id"
    t.index ["updated_by_id"], name: "index_projects_on_updated_by_id"
  end

  create_table "todos", force: :cascade do |t|
    t.string "task"
    t.date "expected_start"
    t.date "expected_end"
    t.integer "project_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.index ["created_by_id"], name: "index_todos_on_created_by_id"
    t.index ["project_id"], name: "index_todos_on_project_id"
    t.index ["updated_by_id"], name: "index_todos_on_updated_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "uid"
    t.boolean "admin", default: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "worker_todos", force: :cascade do |t|
    t.integer "worker_id"
    t.integer "todo_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_worker_todos_on_created_by_id"
    t.index ["todo_id"], name: "index_worker_todos_on_todo_id"
    t.index ["updated_by_id"], name: "index_worker_todos_on_updated_by_id"
    t.index ["worker_id"], name: "index_worker_todos_on_worker_id"
  end

  create_table "workers", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_workers_on_created_by_id"
    t.index ["updated_by_id"], name: "index_workers_on_updated_by_id"
    t.index ["user_id"], name: "index_workers_on_user_id"
  end

end
