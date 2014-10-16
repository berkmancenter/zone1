class RemoveDispositionTextField < ActiveRecord::Migration
  def up
    remove_column :stored_files, :disposition
  end

  def down
    add_column :stored_files, :disposition, :string
  end
end
