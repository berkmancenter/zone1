class StoredFilesTweaks < ActiveRecord::Migration
  def up
    remove_column :stored_files, :license_terms
    remove_column :stored_files, :ingest_date
    remove_column :stored_files, :collection_name
    execute "alter table stored_files alter column content_type_id drop not null"
    execute "alter table stored_files alter column original_filename drop not null"
  end

  def down
    add_column :stored_files, :license_terms, :string
    add_column :stored_files, :ingest_date, :datetime
    add_column :stored_files, :collection_name, :string
    execute "alter table stored_files alter column content_type_id set not null"
    execute "alter table stored_files alter column original_filename set not null"
  end
end
