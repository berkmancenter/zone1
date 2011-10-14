class ChangeFlagsDisplay < ActiveRecord::Migration
  def change
	rename_column :flags, :display, :label
  end
end
