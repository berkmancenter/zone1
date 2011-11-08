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

ActiveRecord::Schema.define(:version => 20111107204438) do

  create_table "access_levels", :force => true do |t|
    t.string "name",  :null => false
    t.string "label", :null => false
  end

  create_table "batches", :force => true do |t|
    t.integer "user_id", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "stored_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_types", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "disposition_actions", :force => true do |t|
    t.string "action"
  end

  create_table "dispositions", :force => true do |t|
    t.integer  "disposition_action_id"
    t.integer  "stored_file_id"
    t.text     "location"
    t.text     "note"
    t.datetime "action_date"
  end

  create_table "flaggings", :force => true do |t|
    t.integer "flag_id"
    t.integer "stored_file_id"
    t.integer "user_id"
    t.text    "note"
  end

  create_table "flags", :force => true do |t|
    t.string "name",  :null => false
    t.string "label", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_owners", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "owner_id"
  end

  create_table "groups_stored_files", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "stored_file_id"
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "licenses", :force => true do |t|
    t.integer  "stored_file_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preferences", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "right_assignments", :force => true do |t|
    t.integer "right_id"
    t.integer "subject_id"
    t.string  "subject_type"
  end

  create_table "rights", :force => true do |t|
    t.string "action"
    t.string "description"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_groups", :id => false, :force => true do |t|
    t.integer  "group_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sftp_groups", :id => false, :force => true do |t|
    t.integer  "id",         :null => false
    t.string   "name"
    t.text     "members"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sftp_users", :id => false, :force => true do |t|
    t.integer  "user_id",       :null => false
    t.string   "username"
    t.string   "passwd"
    t.integer  "uid"
    t.integer  "sftp_group_id"
    t.string   "homedir"
    t.string   "shell"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stored_files", :force => true do |t|
    t.integer  "batch_id"
    t.integer  "user_id",                              :null => false
    t.string   "title"
    t.string   "original_filename",                    :null => false
    t.string   "collection_name"
    t.string   "office"
    t.integer  "access_level_id",                      :null => false
    t.integer  "content_type_id",                      :null => false
    t.string   "format_name"
    t.string   "format_version"
    t.string   "mime_type"
    t.string   "md5"
    t.integer  "file_size"
    t.text     "description"
    t.text     "copyright"
    t.datetime "ingest_date"
    t.text     "license_terms"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.string   "author"
    t.integer  "license_id"
    t.datetime "deletion_date"
    t.boolean  "allow_notes",       :default => false
    t.boolean  "delete_flag"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name",                                                  :null => false
    t.string   "affiliation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quota_used"
    t.integer  "quota_max"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
