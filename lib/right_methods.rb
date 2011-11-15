module RightMethods
  # TODO: Server side validation on flag toggling here
  def toggle_flag(flag)
    begin
      stored_file = StoredFile.find(params[:id])

      if params.has_key?(:checked) && !stored_file.flags.include?(flag)
        stored_file.flags << flag
        stored_file.save
      elsif !params.has_key?(:checked) && stored_file.flags.include?(flag)
        stored_file.flags.delete(flag)
        stored_file.save
      end

      render :json => { :success => true }
    rescue Exception => e
      render :json => {:success => false, :message => e.to_s}
      logger.warn "Warning: stored_files_controller.create got exception: #{e}"
    end
  end

  def add_preserved
    flag = Flag.find_by_name("PRESERVED")
    toggle_flag(flag)
  end 

  def add_nominated_for_preservation
    flag = Flag.find_by_name("NOMINATED_FOR_PRESERVATION")
    toggle_flag(flag)
  end

  def add_selected_for_preservation
    flag = Flag.find_by_name("SELECTED_FOR_PRESERVATION")
    toggle_flag(flag)
  end

  def add_university_record
    flag = Flag.find_by_name("UNIVERSITY_RECORD")
    toggle_flag(flag)
  end

  def add_may_be_university_record
    flag = Flag.find_by_name("MAY_BE_UNIVERSITY_RECORD")
    toggle_flag(flag)
  end

  def toggle_access_level(access_level)
    begin
      stored_file = StoredFile.find(params[:id])
      stored_file.update_attribute(:access_level, access_level.id)

      render :json => { :success => true }
    rescue Exception => e
      render :json => {:success => false, :message => e.to_s}
      logger.warn "Warning: stored_files_controller.create got exception: #{e}"
    end
  end

  def toggle_open
    toggle_access_level(AccessLevel.find_by_name("open"))
  end

  def toggle_partially_open
    toggle_access_level(AccessLevel.find_by_name("partially_open"))
  end

  def toggle_dark
    toggle_access_level(AccessLevel.find_by_name("dark"))
  end

  def update_disposition; end
  #def delete_item; end
  #def delete_item_to_own_content; end
  #def view_item; end 
  #def view_item_to_own_content; end
  #def view_all_items; end
  #def view_preserved_flag_content; end
end
