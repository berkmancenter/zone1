class PreferencesRefactor < ActiveRecord::Migration
  # Rename :name to :label, then create new :name column populated with programatically sane names
  def up
    rename_column :preferences, :name, :label
    add_column :preferences, :name, :string

    execute "update preferences set name = 'default_user_upload_quota' where label = 'Default User Upload Quota' "
    execute "update preferences set name = 'max_web_upload_filesize' where label = 'Max Web Upload Filesize' "
    execute "update preferences set name = 'default_license' where label = 'Default License' "
    execute "update preferences set name = 'group_invite_from_address' where label = 'Group Invite Email From Address' "
    execute "update preferences set name = 'soft_delete_retention_period' where label = 'Retention Period' "

    Preference.create :name => 'group_invite_pending_duration', :label => "Group Invite Pending Invite Expiration (Days)", :value => "90"
  end

  def down
    Preference.find_by_name('group_invite_pending_duration').destroy
    
    execute "update preferences set name = label"
    remove_column :preferences, :name
    rename_column :preferences, :label, :name
  end
end
