class ChangeAccessId < ActiveRecord::Migration
  def change 
	rename_column :access_levels, :display, :label	
  end
end
