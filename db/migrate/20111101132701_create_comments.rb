class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, :nil => false
      t.references :user, :nil => false
      t.references :stored_file, :nil => false
      t.timestamps
    end
  end
end
