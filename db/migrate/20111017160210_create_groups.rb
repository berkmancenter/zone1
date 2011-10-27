class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
  	  t.string :name
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
