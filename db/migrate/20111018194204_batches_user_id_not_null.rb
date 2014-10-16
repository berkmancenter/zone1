class BatchesUserIdNotNull < ActiveRecord::Migration
  def up
    execute "alter table batches alter column user_id set not null" 
  end

  def down
    execute "alter table batches alter column user_id drop not null" 
  end
end
