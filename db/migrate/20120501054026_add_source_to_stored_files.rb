class AddSourceToStoredFiles < ActiveRecord::Migration
  def change
    add_column :stored_files, :source, :string
  end
end
