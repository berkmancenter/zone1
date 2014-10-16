class AddIconToMimeTypeCategory < ActiveRecord::Migration
  def change
    add_column :mime_type_categories, :icon, :string
  end
end
