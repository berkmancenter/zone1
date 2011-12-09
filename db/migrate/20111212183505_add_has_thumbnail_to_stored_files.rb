class AddHasThumbnailToStoredFiles < ActiveRecord::Migration
  def change
    add_column :stored_files, :has_thumbnail, :boolean, :default => false
  end
end
