class CreateRights < ActiveRecord::Migration
  def change
    create_table :rights do |t|
      t.string :method
      t.string :description
    end
  end
end
