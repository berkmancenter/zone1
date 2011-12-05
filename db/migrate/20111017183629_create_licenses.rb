class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.references :stored_file
  	  t.string :name
      t.timestamps
    end
    add_index :licenses, :stored_file_id
  end
end
