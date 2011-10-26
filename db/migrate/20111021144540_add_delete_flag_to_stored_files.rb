class AddDeleteFlagToStoredFiles < ActiveRecord::Migration
  def up
	add_column :stored_files, :delete_flag, :boolean
  end

  def down
	remove_column :stored_files, :delete_flag
  end
end
