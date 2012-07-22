class RemoveDeletedAtFromFlaggings < ActiveRecord::Migration
  def up
   remove_column :flaggings, :deleted_at 
  end

  def down
    add_column :flaggings, :deleted_at, :datetime
  end
end
