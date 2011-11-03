class CreateDispositionActions < ActiveRecord::Migration
  def change
    create_table :disposition_actions do |t|
      t.string :action
    end
  end
end
