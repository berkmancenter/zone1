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

ActiveRecord::Schema.define(:version => 20121017215909) do

  create_table "access_levels", :force => true do |t|
    t.string "name",  :null => false
    t.string "label", :null => false
  end

  create_table "batches", :force => true do |t|
    t.integer "user_id", :null => false
  end

  add_index "batches", ["user_id"], :name => "index_batches_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "stored_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "comments", ["stored_file_id"], :name => "index_comments_on_stored_file_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "disposition_actions", :force => true do |t|
    t.string "action"
  end

  create_table "dispositions", :force => true do |t|
    t.integer  "disposition_action_id"
    t.integer  "stored_file_id"
    t.text     "location"
    t.text     "note"
    t.datetime "action_date"
    t.datetime "deleted_at"
  end

  add_index "dispositions", ["disposition_action_id"], :name => "index_dispositions_on_disposition_action_id"
  add_index "dispositions", ["stored_file_id"], :name => "index_dispositions_on_stored_file_id"

  create_table "flaggings", :force => true do |t|
    t.integer "flag_id"
    t.integer "stored_file_id"
    t.integer "user_id"
    t.text    "note"
  end

  add_index "flaggings", ["flag_id"], :name => "index_flaggings_on_flag_id"
  add_index "flaggings", ["stored_file_id"], :name => "index_flaggings_on_stored_file_id"
  add_index "flaggings", ["user_id"], :name => "index_flaggings_on_user_id"

  create_table "flags", :force => true do |t|
    t.string "name",  :null => false
    t.string "label", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "assignable_rights", :default => false
  end

  create_table "groups_stored_files", :force => true do |t|
    t.integer "group_id"
    t.integer "stored_file_id"
  end

  add_index "groups_stored_files", ["group_id"], :name => "index_groups_stored_files_on_group_id"
  add_index "groups_stored_files", ["stored_file_id"], :name => "index_groups_stored_files_on_stored_file_id"

  create_table "licenses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.boolean  "is_owner",        :default => false
    t.datetime "joined_at"
    t.integer  "invited_by"
    t.string   "membership_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["group_id"], :name => "index_memberships_on_group_id"
  add_index "memberships", ["membership_code"], :name => "index_memberships_on_membership_code"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "mime_type_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon"
  end

  create_table "mime_types", :force => true do |t|
    t.string   "name"
    t.string   "extension"
    t.string   "mime_type"
    t.integer  "mime_type_category_id"
    t.boolean  "blacklist"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mime_types", ["mime_type"], :name => "index_mime_types_on_mime_type"
  add_index "mime_types", ["mime_type_category_id"], :name => "index_mime_types_on_mime_type_category_id"

  create_table "preferences", :force => true do |t|
    t.string   "label"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "right_assignments", :force => true do |t|
    t.integer "right_id"
    t.integer "subject_id"
    t.string  "subject_type"
  end

  add_index "right_assignments", ["right_id"], :name => "index_right_assignments_on_right_id"
  add_index "right_assignments", ["subject_id", "subject_type"], :name => "index_right_assignments_on_subject_id_and_subject_type"

  create_table "rights", :force => true do |t|
    t.string "action"
    t.string "description"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.integer  "authorizable_id"
    t.string   "authorizable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["authorizable_id", "authorizable_type"], :name => "index_roles_on_authorizable_id_and_authorizable_type"

  create_table "roles_groups", :id => false, :force => true do |t|
    t.integer  "group_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles_groups", ["group_id"], :name => "index_roles_groups_on_group_id"
  add_index "roles_groups", ["role_id"], :name => "index_roles_groups_on_role_id"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "sftp_groups", :id => false, :force => true do |t|
    t.integer  "id",         :null => false
    t.string   "name"
    t.text     "members"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sftp_users", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.string   "username",      :null => false
    t.string   "passwd",        :null => false
    t.integer  "uid"
    t.integer  "sftp_group_id"
    t.string   "homedir"
    t.string   "shell"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sftp_users", ["passwd"], :name => "index_sftp_users_on_passwd"
  add_index "sftp_users", ["username"], :name => "index_sftp_users_on_username"

  create_table "stored_files", :force => true do |t|
    t.integer  "batch_id"
    t.integer  "user_id",                              :null => false
    t.string   "title"
    t.string   "original_filename"
    t.string   "office"
    t.integer  "access_level_id",                      :null => false
    t.string   "format_version"
    t.string   "md5"
    t.integer  "file_size"
    t.text     "description"
    t.text     "copyright_holder"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.string   "author"
    t.integer  "license_id"
    t.datetime "deletion_date"
    t.boolean  "allow_notes",       :default => false
    t.boolean  "delete_flag"
    t.boolean  "allow_tags"
    t.integer  "mime_type_id"
    t.date     "original_date"
    t.boolean  "has_thumbnail",     :default => false
    t.datetime "deleted_at"
    t.boolean  "complete",          :default => false
    t.string   "source"
  end

  add_index "stored_files", ["access_level_id"], :name => "index_stored_files_on_access_level_id"
  add_index "stored_files", ["batch_id"], :name => "index_stored_files_on_batch_id"
  add_index "stored_files", ["license_id"], :name => "index_stored_files_on_license_id"
  add_index "stored_files", ["mime_type_id"], :name => "index_stored_files_on_mime_type_id"
  add_index "stored_files", ["user_id"], :name => "index_stored_files_on_user_id"

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
  add_index "taggings", ["tagger_id", "tagger_type"], :name => "index_taggings_on_tagger_id_and_tagger_type"

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
    t.integer  "quota_used",                            :default => 0
    t.integer  "quota_max"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
