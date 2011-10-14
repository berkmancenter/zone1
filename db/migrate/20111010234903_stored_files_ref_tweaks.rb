class StoredFilesRefTweaks < ActiveRecord::Migration
  def up
    # fix typo in original stored_files creation
    rename_column :stored_files, :batch_id_id, :batch_id
  end

  def down
    rename_column :stored_files, :batch_id, :batch_id_id
  end
end
