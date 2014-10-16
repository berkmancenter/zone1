class AddDefaultValueToUserQuotaUsed < ActiveRecord::Migration
  def up
    change_column_default(:users, :quota_used, 0)
  end
  
  def down
    change_column_default(:users, :quota_used, nil)
  end
  
end

