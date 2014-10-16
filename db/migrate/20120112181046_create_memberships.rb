require File.expand_path("../../migration_helper", __FILE__)

class CreateMemberships < ActiveRecord::Migration
  include MigrationHelper
  def change
    create_table :memberships do |t|
      t.integer :group_id
      t.integer :user_id
      t.boolean :is_owner, :default => false
      t.datetime :joined_at
      t.integer :invited_by
      t.string :membership_code
      t.timestamps
    end

    add_index :memberships, :group_id
    add_index :memberships, :user_id
    add_index :memberships, :membership_code
    pg_foreign_key :memberships, :group_id, :groups
    pg_foreign_key :memberships, :user_id, :users
  end
end
