class CreateAccessLevels < ActiveRecord::Migration
  def change
    create_table :access_levels do |t|
      t.string :name, :null => false
      t.string :label, :null => false
    end
  end
end
