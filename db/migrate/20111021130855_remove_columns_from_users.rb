class RemoveColumnsFromUsers < ActiveRecord::Migration
  def up
	remove_column :users, :title
	remove_column :users, :office
  end

  def down
	add_column :users, :title, :string
	add_column :users, :office, :string
  end
end
