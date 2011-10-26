class AddFieldsToStoredFiles < ActiveRecord::Migration
  def change
    add_column :stored_files, :author, :string
    add_column :stored_files, :title, :string
  end
end
