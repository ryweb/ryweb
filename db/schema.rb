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

ActiveRecord::Schema.define(:version => 20100331192158) do

  create_table "configurations", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "category"
    t.string   "message"
    t.integer  "user_id"
    t.integer  "customer_id"
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graphics", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.integer  "customer_id"
    t.datetime "updated_at"
  end

  create_table "layouts", :force => true do |t|
    t.string   "name"
    t.text     "content",     :limit => 255
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "address"
    t.integer  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  create_table "occasion_types", :force => true do |t|
    t.string   "name"
    t.integer  "visibility",  :default => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  create_table "occasions", :force => true do |t|
    t.string   "name"
    t.datetime "start_time"
    t.string   "internal_info"
    t.string   "public_info"
    t.integer  "state",            :default => 10
    t.integer  "occasion_type_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.integer  "repeat",           :default => 0
    t.date     "repeat_until"
    t.boolean  "inform_changes",   :default => false
  end

  create_table "page_parameters", :force => true do |t|
    t.integer  "page_id"
    t.string   "name"
    t.string   "value"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_versions", :force => true do |t|
    t.integer  "page_id"
    t.integer  "version"
    t.string   "title"
    t.string   "content"
    t.string   "name"
    t.integer  "state"
    t.integer  "public"
    t.integer  "layout_id"
    t.integer  "author_id"
    t.integer  "page_type"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_versions", ["page_id"], :name => "index_page_versions_on_page_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content",     :limit => 255
    t.string   "name"
    t.integer  "state"
    t.integer  "public"
    t.integer  "layout_id"
    t.integer  "author_id"
    t.integer  "page_type"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "styles", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.datetime "created_at"
    t.integer  "customer_id"
    t.datetime "updated_at"
    t.integer  "width"
    t.integer  "height"
    t.integer  "parent_id"
    t.integer  "thumbnail"
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
    t.integer  "customer_id"
    t.integer  "user_level"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
