class AddAllowTagsToStoredFiles < ActiveRecord::Migration
  def change
    add_column :stored_files, :allow_tags, :boolean
  end
end
