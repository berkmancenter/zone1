class AddOriginalDateToStoredFile < ActiveRecord::Migration
  def change
    add_column :stored_files, :original_date, :date
  end
end
