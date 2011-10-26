class CreateRightAssignments < ActiveRecord::Migration
  def change
    create_table :right_assignments do |t|
      t.references :right
      t.integer :subject_id
      t.string :subject_type
    end
  end
end
