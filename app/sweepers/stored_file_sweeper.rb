class StoredFileSweeper < ActionController::Caching::Sweeper
  observe StoredFile
   
  def after_update(stored_file)
    Rails.cache.delete("stored-file-#{stored_file.id}-viewable-users")
  end
                         
  def after_destroy(stored_file)
    Rails.cache.delete("stored-file-#{stored_file.id}-viewable-users")
  end
end
