class CreateStoredFiles < ActiveRecord::Migration
  def change
    create_table :stored_files do |t|
      t.references :batch
      t.references :user, :null => false
      t.string :title
      t.string :original_file_name, :null => false
      t.string :collection_name
      t.string :office
      t.string :disposition
      t.references :access_level, :null => false
      t.references :content_type, :null => false
      t.string :format_name
      t.string :format_version
      t.string :mime_type
      t.string :md5
      t.integer :file_size
      t.text :description
      t.text :copyright_holder
      t.datetime :ingest_date
      t.text :license_terms
      t.timestamps
    end
    add_index :stored_files, :batch_id
    add_index :stored_files, :user_id
    add_index :stored_files, :access_level_id
    add_index :stored_files, :content_type_id
  end
end
