class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.references :stored_file
	  t.string :name
      t.timestamps
    end
  end
end
