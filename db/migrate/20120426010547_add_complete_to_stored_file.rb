class AddCompleteToStoredFile < ActiveRecord::Migration
  def change
    add_column :stored_files, :complete, :boolean, :default => false
  end
end
