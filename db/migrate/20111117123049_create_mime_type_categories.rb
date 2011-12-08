class CreateMimeTypeCategories < ActiveRecord::Migration
  def change
    create_table :mime_type_categories do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
