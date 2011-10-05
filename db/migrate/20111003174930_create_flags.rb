class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.string :name, :null => false
      t.string :display, :null => false
    end
  end
end
