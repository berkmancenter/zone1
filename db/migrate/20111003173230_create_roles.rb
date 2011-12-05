class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, :limit => 40
      t.references :authorizable, :polymorphic => true
      t.timestamps
    end
    add_index :roles, [:authorizable_id, :authorizable_type]
  end
end
