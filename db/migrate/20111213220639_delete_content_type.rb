class DeleteContentType < ActiveRecord::Migration
  def up
    remove_column :stored_files, :content_type_id

    drop_table :content_types
  end

  def down
    add_column :stored_files, :content_type_id, :integer

    create_table :content_types do |t|
      t.string :name, :null => false
    end
  end
end
