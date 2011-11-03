class CreateDispositions < ActiveRecord::Migration
  def change
    create_table :dispositions do |t|
      t.references :disposition_action
      t.references :stored_file
      t.text :location
      t.text :note
      t.datetime :action_date
    end
  end
end
