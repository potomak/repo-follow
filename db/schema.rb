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

ActiveRecord::Schema.define(version: 20140906103635) do

  create_table "branches", force: true do |t|
    t.string   "name"
    t.string   "sha"
    t.integer  "repository_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branches", ["repository_id"], name: "index_branches_on_repository_id"

  create_table "branches_commits", id: false, force: true do |t|
    t.integer "branch_id", null: false
    t.integer "commit_id", null: false
  end

  add_index "branches_commits", ["commit_id", "branch_id"], name: "index_branches_commits_on_commit_id_and_branch_id", unique: true

  create_table "branches_users", id: false, force: true do |t|
    t.integer "branch_id", null: false
    t.integer "user_id",   null: false
  end

  add_index "branches_users", ["user_id", "branch_id"], name: "index_branches_users_on_user_id_and_branch_id", unique: true

  create_table "commits", force: true do |t|
    t.string   "sha"
    t.text     "message"
    t.string   "author"
    t.string   "author_image"
    t.string   "committer"
    t.string   "committer_image"
    t.integer  "repository_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date"
  end

  add_index "commits", ["repository_id"], name: "index_commits_on_repository_id"

  create_table "repositories", force: true do |t|
    t.string   "full_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner"
    t.string   "owner_image"
  end

  add_index "repositories", ["full_name"], name: "index_repositories_on_full_name", unique: true

  create_table "users", force: true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["uid"], name: "index_users_on_uid", unique: true

end
