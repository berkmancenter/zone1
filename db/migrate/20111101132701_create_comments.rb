class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, :nil => false
      t.references :user, :nil => false
      t.references :stored_file, :nil => false
      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :stored_file_id
  end
end
