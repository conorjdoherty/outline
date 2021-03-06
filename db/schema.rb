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

ActiveRecord::Schema.define(:version => 20120523083229) do

  create_table "activities", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "user_id"
    t.integer  "context_id"
    t.integer  "content_id"
    t.string   "action"
    t.string   "verb"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "content_items", :force => true do |t|
    t.integer  "content_id"
    t.integer  "position"
    t.string   "item_type"
    t.integer  "item_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contents", :force => true do |t|
    t.string   "holder_type"
    t.integer  "holder_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "context_id"
  end

  create_table "contexts", :force => true do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "domains", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "theme"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "user_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "links", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "user_id"
    t.integer  "content_id"
    t.text     "href"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "user_id"
    t.integer  "content_id"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "user_id"
    t.string   "title"
    t.boolean  "active",      :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.text     "description"
  end

  create_table "quick_jump_targets", :force => true do |t|
    t.integer  "domain_id"
    t.string   "phrase"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "quick_jump_targets", ["domain_id", "phrase"], :name => "index_quick_jump_targets_on_domain_id_and_phrase"

  create_table "taggings", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "tag_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "taggings", ["resource_id", "resource_type"], :name => "index_taggings_on_resource_id_and_resource_type"
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.integer  "domain_id"
    t.string   "title"
    t.string   "style"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "todo_lists", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "user_id"
    t.integer  "content_id"
    t.string   "title"
    t.integer  "responsible_user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "todos", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "user_id"
    t.integer  "content_id"
    t.string   "title"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "todos", ["content_id", "active"], :name => "index_todos_on_content_id_and_active"

  create_table "users", :force => true do |t|
    t.integer  "domain_id"
    t.string   "login",                                 :null => false
    t.string   "email",                                 :null => false
    t.string   "crypted_password",                      :null => false
    t.string   "password_salt",                         :null => false
    t.string   "persistence_token",                     :null => false
    t.string   "single_access_token",                   :null => false
    t.string   "perishable_token",                      :null => false
    t.integer  "login_count",         :default => 0,    :null => false
    t.integer  "failed_login_count",  :default => 0,    :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "domain_admin",        :default => true
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

end
