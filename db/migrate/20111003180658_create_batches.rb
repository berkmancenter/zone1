class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.references :user
    end
  end
end
