class CreateFlaggings < ActiveRecord::Migration
  def change
    create_table :flaggings do |t|
      t.references :flag, :nil => false
      t.references :stored_file, :nil => false
      t.references :user, :nil => false
      t.text :note
      #t.timestamps
    end
  end
end
