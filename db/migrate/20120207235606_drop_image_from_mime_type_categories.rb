class DropImageFromMimeTypeCategories < ActiveRecord::Migration
  def up
    remove_column :mime_type_categories, :image
  end

  def down
    add_column :mime_type_categories, :image, :string
  end
end
