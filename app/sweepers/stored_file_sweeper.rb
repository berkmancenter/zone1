class StoredFileSweeper < ActionController::Caching::Sweeper
  observe StoredFile
   
  def after_update(stored_file)
    Rails.cache.delete("stored-file-users-#{stored_file.id}")
  end
                         
  def after_destroy(stored_file)
    Rails.cache.delete("stored-file-users-#{stored_file.id}")
  end
end
