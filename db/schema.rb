# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090214020726) do

  create_table "apps", :force => true do |t|
    t.string   "name"
    t.string   "admin"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "anonymous"
  end

  create_table "client_maps", :id => false, :force => true do |t|
    t.string   "client_id",       :limit => 36
    t.integer  "object_value_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_maps", ["client_id", "object_value_id"], :name => "client_map_c_id_ov_id"
  add_index "client_maps", ["client_id"], :name => "client_map_c_id"

  create_table "clients", :id => false, :force => true do |t|
    t.string   "client_id",  :limit => 36
    t.string   "session"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "clients", ["client_id"], :name => "index_clients_on_client_id"

  create_table "credentials", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "membership_id"
    t.string   "url"
  end

  create_table "credentials_sources", :force => true do |t|
    t.integer  "credential_id"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "app_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "object_values", :force => true do |t|
    t.integer  "source_id"
    t.string   "attrib"
    t.string   "object"
    t.text     "value"
    t.string   "update_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pending_id"
    t.integer  "user_id"
  end

  add_index "object_values", ["id"], :name => "by_ov_id"
  add_index "object_values", ["source_id", "user_id", "update_type"], :name => "by_source_user_type"

  create_table "source_logs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "method"
    t.string   "login"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "prolog"
    t.text     "epilog"
    t.text     "call"
    t.text     "sync"
    t.string   "type"
    t.text     "createcall"
    t.text     "updatecall"
    t.text     "deletecall"
    t.datetime "refreshtime"
    t.string   "adapter"
    t.integer  "app_id"
    t.integer  "pollinterval"
    t.integer  "priority"
    t.integer  "incremental"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
