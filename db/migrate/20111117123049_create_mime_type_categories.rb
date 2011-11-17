class CreateMimeTypeCategories < ActiveRecord::Migration
  def change
    create_table :mime_type_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
