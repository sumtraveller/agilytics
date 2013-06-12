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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130603204313) do

  create_table "agile_users", :force => true do |t|
    t.string   "pid"
    t.string   "name"
    t.string   "display_name"
    t.string   "email_address"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "boards", :force => true do |t|
    t.string   "pid"
    t.string   "name"
    t.boolean  "is_sprint_board"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "cards", :force => true do |t|
    t.string   "pid"
    t.string   "acuity"
    t.datetime "create_date"
    t.datetime "done_date"
    t.boolean  "done"
    t.integer  "size"
    t.string   "status"
    t.string   "location"
    t.integer  "board_id"
    t.integer  "sprint_id"
    t.integer  "assignee_id"
    t.integer  "reporter_id"
    t.string   "associated_story_pid"
    t.string   "associated_subtask_pid"
    t.string   "card_type"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "changes", :force => true do |t|
    t.string   "action"
    t.string   "pid"
    t.datetime "time"
    t.string   "board_pid"
    t.string   "sprint_pid"
    t.string   "location"
    t.string   "status"
    t.string   "associated_story_pid"
    t.string   "associated_subtask_pid"
    t.string   "new_value"
    t.string   "old_value"
    t.integer  "board_id"
    t.integer  "sprint_id"
    t.boolean  "is_done"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "sprints", :force => true do |t|
    t.string   "pid"
    t.string   "name"
    t.boolean  "closed"
    t.integer  "velocity"
    t.boolean  "have_all_changes"
    t.boolean  "have_processed_all_changes"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "board_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "subtasks", :force => true do |t|
    t.string   "pid"
    t.string   "acuity"
    t.string   "associated_story_pid"
    t.string   "associated_subtask_pid"
    t.datetime "create_date"
    t.datetime "done_date"
    t.boolean  "done"
    t.integer  "size"
    t.string   "status"
    t.string   "location"
    t.integer  "sprint_id"
    t.integer  "assignee_id"
    t.integer  "reporter_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

end
