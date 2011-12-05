class CreateFlaggings < ActiveRecord::Migration
  def change
    create_table :flaggings do |t|
      t.references :flag, :nil => false
      t.references :stored_file, :nil => false
      t.references :user, :nil => false
      t.text :note
    end
    add_index :flaggings, :flag_id
    add_index :flaggings, :stored_file_id
    add_index :flaggings, :user_id
  end
end
