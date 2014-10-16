class RemoveMimeTypeNameFromMimeType < ActiveRecord::Migration
  def up
    remove_column :mime_types, :mime_type_name
  end

  def down
    add_column :mime_types, :mime_type_name, :string
  end
end
