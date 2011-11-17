class CreateMimeTypes < ActiveRecord::Migration
  def change
    create_table :mime_types do |t|
      t.string :name
      t.string :extension
      t.string :mime_type
      t.references :mime_type_category
      t.boolean :blacklist

      t.timestamps
    end

    add_index :mime_types, :mime_type
  end
end
