class CreateStoredFiles < ActiveRecord::Migration
  def change
    create_table :stored_files do |t|
      t.references :batch_id
      t.references :user, :null => false
      t.string :original_file_name, :null => false
      t.string :collection_name
      t.references :access_level, :null => false
      t.references :content_type, :null => false
      t.date :retention_plan_date
      t.string :retention_plan_action
      t.string :format_name
      t.string :format_version
      t.string :mime_type
      t.string :md5
      t.integer :file_size
      t.text :description
      t.text :copyright
      t.datetime :ingest_date
      t.text :license_terms
      t.timestamps
    end
  end
end
