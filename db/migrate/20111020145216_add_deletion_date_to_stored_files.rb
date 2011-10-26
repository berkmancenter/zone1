class AddDeletionDateToStoredFiles < ActiveRecord::Migration
  def change
    add_column :stored_files, :deletion_date, :datetime
  end
end
