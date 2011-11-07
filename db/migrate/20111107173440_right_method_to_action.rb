class RightMethodToAction < ActiveRecord::Migration
  def up
    rename_column :rights, :method, :action
  end

  def down
    rename_column :rights, :action, :method
  end
end
