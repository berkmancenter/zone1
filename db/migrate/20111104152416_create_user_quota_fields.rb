class CreateUserQuotaFields < ActiveRecord::Migration
  def change
    add_column :users, :quota_used, :integer
    add_column :users, :quota_max, :integer
  end
end
