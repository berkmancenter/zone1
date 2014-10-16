class AddOfficeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :office, :string
    add_column :users, :title, :string
  end
end
