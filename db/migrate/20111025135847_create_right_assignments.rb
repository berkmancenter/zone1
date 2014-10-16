class CreateRightAssignments < ActiveRecord::Migration
  def change
    create_table :right_assignments do |t|
      t.references :right
      t.references :subject, :polymorphic => true
    end
    add_index :right_assignments, :right_id
    add_index :right_assignments, [:subject_id, :subject_type]
  end
end
