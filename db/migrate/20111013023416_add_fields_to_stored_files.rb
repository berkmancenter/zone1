class AddFieldsToStoredFiles < ActiveRecord::Migration
  def change
    add_column :stored_files, :author, :string
  end
end
