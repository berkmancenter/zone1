require File.expand_path("../../migration_helper", __FILE__)

class AddForeignKeys < ActiveRecord::Migration
  include MigrationHelper
  def up
    pg_foreign_key :batches, :user_id, :users
    pg_foreign_key :comments, :user_id, :users
    pg_foreign_key :comments, :stored_file_id, :stored_files
    pg_foreign_key :dispositions, :disposition_action_id, :disposition_actions
    pg_foreign_key :dispositions, :stored_file_id, :stored_files
    pg_foreign_key :flaggings, :flag_id, :flags
    pg_foreign_key :flaggings, :stored_file_id, :stored_files
    pg_foreign_key :flaggings, :user_id, :users
    pg_foreign_key :groups_owners, :group_id, :groups
    pg_foreign_key :groups_owners, :owner_id, :users
    pg_foreign_key :groups_stored_files, :group_id, :groups
    pg_foreign_key :groups_stored_files, :stored_file_id, :stored_files
    pg_foreign_key :groups_users, :user_id, :users
    pg_foreign_key :groups_users, :group_id, :groups
    pg_foreign_key :licenses, :stored_file_id, :stored_files 
    pg_foreign_key :mime_types, :mime_type_category_id, :mime_type_categories
    pg_foreign_key :right_assignments, :right_id, :rights
    pg_foreign_key :roles_groups, :group_id, :groups
    pg_foreign_key :roles_groups, :role_id, :roles
    pg_foreign_key :roles_users, :user_id, :users
    pg_foreign_key :roles_users, :role_id, :roles
    pg_foreign_key :sftp_users, :user_id, :users
    pg_foreign_key :stored_files, :batch_id, :batches
    pg_foreign_key :stored_files, :user_id, :users
    pg_foreign_key :stored_files, :access_level_id, :access_levels
    pg_foreign_key :stored_files, :license_id, :licenses 
    pg_foreign_key :stored_files, :mime_type_id, :mime_types
    pg_foreign_key :taggings, :tag_id, :tags
  end

  def down
    drop_pg_foreign_key :batches, :user_id, :users
    drop_pg_foreign_key :comments, :user_id, :users
    drop_pg_foreign_key :comments, :stored_file_id, :stored_files
    drop_pg_foreign_key :dispositions, :disposition_action_id, :disposition_actions
    drop_pg_foreign_key :dispositions, :stored_file_id, :stored_files
    drop_pg_foreign_key :flaggings, :flag_id, :flags
    drop_pg_foreign_key :flaggings, :stored_file_id, :stored_files
    drop_pg_foreign_key :flaggings, :user_id, :users
    drop_pg_foreign_key :groups_owners, :group_id, :groups
    drop_pg_foreign_key :groups_owners, :owner_id, :users
    drop_pg_foreign_key :groups_stored_files, :group_id, :groups
    drop_pg_foreign_key :groups_stored_files, :stored_file_id, :stored_files
    drop_pg_foreign_key :groups_users, :user_id, :users
    drop_pg_foreign_key :groups_users, :group_id, :groups
    drop_pg_foreign_key :licenses, :stored_file_id, :stored_files
    drop_pg_foreign_key :mime_types, :mime_type_category_id, :mime_type_categories
    drop_pg_foreign_key :right_assignments, :right_id, :rights
    drop_pg_foreign_key :roles_groups, :group_id, :groups
    drop_pg_foreign_key :roles_groups, :role_id, :roles
    drop_pg_foreign_key :roles_users, :user_id, :users
    drop_pg_foreign_key :roles_users, :role_id, :roles
    drop_pg_foreign_key :sftp_users, :user_id, :users
    drop_pg_foreign_key :stored_files, :batch_id, :batches
    drop_pg_foreign_key :stored_files, :user_id, :users
    drop_pg_foreign_key :stored_files, :access_level_id, :access_levels
    drop_pg_foreign_key :stored_files, :license_id, :licenses 
    drop_pg_foreign_key :stored_files, :mime_type_id, :mime_types
    drop_pg_foreign_key :taggings, :tag_id, :tags
  end
end
