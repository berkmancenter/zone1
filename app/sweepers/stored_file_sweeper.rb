class StoredFileSweeper < ActionController::Caching::Sweeper
  observe StoredFile
   
  # If our sweeper detects that a Product was created call this
  def after_create(stored_file)
    expire_cache_for(stored_file)
  end
              
  # If our sweeper detects that a Product was updated call this
  def after_update(stored_file)
    expire_cache_for(stored_file)
  end
                         
  # If our sweeper detects that a Product was deleted call this
  def after_destroy(stored_file)
    expire_cache_for(stored_file)
  end
                                    
  private
    def expire_cache_for(stored_file)
      expire_page(:controller => 'stored_files', :action => 'show')
    end
end
