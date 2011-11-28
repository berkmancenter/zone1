class BulkEditsController < ApplicationController

  include ApplicationHelper

  def new
    if params[:stored_file_ids].is_a?(Array) && params[:stored_file_ids].length > 1
      @stored_files = StoredFile.find(params[:stored_file_ids])

      @attr_accessible = BulkEdit.bulk_editable_attributes(@stored_files, current_user)
 
      matching_attributes = BulkEdit.matching_attributes_from(@stored_files)
      
      @stored_file = StoredFile.new
      @stored_file.accessible = @attr_accessible  #must define accessible before setting attributes
      @stored_file.attributes = matching_attributes
      @stored_file.build_bulk_flaggings_for(@stored_files, current_user)
      @stored_file.build_bulk_groups_for(@stored_files, current_user)

      @licenses = License.all
    
    elsif params[:stored_file_ids].is_a?(Array) && params[:stored_file_ids].length == 1
      redirect_to edit_stored_file_path(params[:stored_file_ids].first)
    
    else
      redirect_to search_path
    end
  end

  def create
    begin 
    unless params.has_key? :attr_for_bulk_edit

      raise "Please select items to update."

    else
      stored_files = StoredFile.find(params[:stored_file_ids])


      stored_files.each do |stored_file|

         #TODO only append flagging and groups params per stored_file, get rest of params once, not in loop
         eligible_params = eligible_params_for(stored_file)

         stored_file.custom_save(eligible_params, current_user)
      
      end
      
      #redirect_to search_path
      redirect_to :action => "new", :stored_file_ids => params[:stored_file_ids]
    end

    rescue Exception => e
      log_exception e
      respond_to do |format|
        format.json { render :json => { :success => false, :message => e.to_s } }
        format.html do
          flash[:error] = "Bulk update failed: #{e}"
          redirect_to :action => "new", :stored_file_ids => params[:stored_file_ids] 
        end
      end
    end
  end

  def eligible_params_for(stored_file)
    eligible_params = {}

    params[:attr_for_bulk_edit].each do |attr|
      eligible_params.merge!({ attr => params[:stored_file][attr] }) if params[:stored_file].has_key?(attr)

      if attr.is_a?(Hash) 
        
        if attr.has_key?("flag_ids") && params[:stored_file].has_key?("flaggings_attributes")


          flagging_attributes = eligible_flagging_attributes(stored_file, attr[:flag_ids], params[:stored_file][:flaggings_attributes])
      
          eligible_params.merge! flagging_attributes


        elsif attr.has_key?("group_ids") && params[:stored_file].has_key?("groups_stored_files_attributes")


          group_attributes = eligible_group_attributes(stored_file, attr[:group_ids], params[:stored_file][:groups_stored_files_attributes])

          eligible_params.merge! group_attributes


        end
      end
    end

    eligible_params
  end

  def eligible_flagging_attributes(stored_file, flag_ids, flagging_attributes)
    eligible_flaggings = {}

    flagging_attributes.each do |key, flagging|
      if flag_ids.include?(flagging[:flag_id]) #we've found an eligible flagging

        if flagging[:_destroy] == "1" 
          #If the flagging needs to be destroyed, we must find the flagging.id for the stored_file and include it in the params       
          flagging_id = stored_file.find_flagging_id_by_flag_id(flagging[:flag_id]) 

          flagging[:id] = flagging_id if flagging_id.present?  #flagging_id wont be found when stored file doesn't have the flag set
        end


        eligible_flaggings.merge!({key => flagging})

      end
    end

    {"flaggings_attributes" => eligible_flaggings}
  end

  def eligible_group_attributes(stored_file, group_ids, group_attributes)
    eligible_groups = {}

    group_attributes.each do |key, group|
      if group_ids.include?(group[:group_id])

        if group[:_destroy] == "1"
          #If groups_stored_files needs to be destroyed, we must find the group_stored_files.id for this particular stored file
          groups_stored_files_id = stored_file.find_groups_stored_files_id_by_group_id(group[:group_id])

          group[:id] = groups_stored_files_id if groups_stored_files_id.present? #won't be found when stored file doesn't have the group
        end


        eligible_groups.merge!({key => group})

      end
    end

    {"groups_stored_files_attributes" => eligible_groups}
  end

end
