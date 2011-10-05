class CreateAccessLevels < ActiveRecord::Migration
  def change
    create_table :access_levels do |t|
      t.string :name, :null => false
      t.string :display, :null => false
    end
  end
end
