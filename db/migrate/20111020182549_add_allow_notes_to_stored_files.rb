class AddAllowNotesToStoredFiles < ActiveRecord::Migration
  def change
    add_column :stored_files, :allow_notes, :boolean
  end
end
