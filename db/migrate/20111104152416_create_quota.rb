class CreateQuota < ActiveRecord::Migration
  def change
    create_table :quota do |t|
      t.integer :used, :default => 0
      t.integer :max, :default => 10485760
      t.integer :user_id

      t.timestamps
    end
    add_index :quota, :user_id
  end
end
