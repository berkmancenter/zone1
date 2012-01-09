class AddDeletedAtToStoredFile < ActiveRecord::Migration
  def change
    add_column :stored_files, :deleted_at, :datetime
    add_column :comments, :deleted_at, :datetime
    add_column :flaggings, :deleted_at, :datetime
    add_column :dispositions, :deleted_at, :datetime
  end
end
