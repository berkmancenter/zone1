class BulkEditsController < ApplicationController

  include ApplicationHelper

  def new
    if params[:stored_file_ids].is_a?(Array) && params[:stored_file_ids].length > 1
      @stored_files = StoredFile.find(params[:stored_file_ids])

      @attr_accessible = BulkEdit.bulk_editable_attributes(@stored_files, current_user)
 
      matching_attributes = BulkEdit.matching_attributes_from(@stored_files)
      
      @stored_file = StoredFile.new
      @stored_file.accessible = @attr_accessible + [:user_id]  #must define accessible before setting attributes
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

      #Run the bulk edit inside a transaction because
      #if one save completes but another fails, all changes
      #should be rolled back.  This also covers issues clearing
      #flaggings or groups.
      StoredFile.transaction do

        #Does not include flaggings or groups.
        #These must be customized for each stored file.
        eligible_params = eligible_params_for_bulk_edit
        
        stored_files.each do |stored_file|

          stored_file_params = eligible_params.clone #always start with same base

          #customize flaggings and groups per stored file
          stored_file_params.merge! flaggings_attributes_for(stored_file)
          stored_file_params.merge! groups_attributes_for(stored_file)

          logger.debug "custom stored file params used for bulk edit = #{stored_file_params.inspect}"

          stored_file.custom_save(stored_file_params, current_user)

        end #stored_file.each
      end #StoredFile.transaction
      
      flash[:notice] = "Files updated."
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

  def flaggings_attributes_for(stored_file)
    flagging_attributes = {}
    params[:attr_for_bulk_edit].each do |attr|

      if attr.is_a?(Hash) 
        
        if attr.has_key?("flag_ids") && params[:stored_file].has_key?("flaggings_attributes")

          flagging_attributes.merge! eligible_flagging_attributes(stored_file, attr[:flag_ids], params[:stored_file][:flaggings_attributes])
        end
      end #attr.is_a?
    end #params loop
    return flagging_attributes
  end

  def groups_attributes_for(stored_file)
    group_attributes = {}
    params[:attr_for_bulk_edit].each do |attr|

      if attr.is_a?(Hash) 
        
        if attr.has_key?("group_ids") && params[:stored_file].has_key?("groups_stored_files_attributes")

          group_attributes.merge! eligible_group_attributes(stored_file, attr[:group_ids], params[:stored_file][:groups_stored_files_attributes])
        end
      end #attr.is_a?
    end #params loop
    return group_attributes
  end



  def eligible_params_for_bulk_edit
    eligible_params = {}

    params[:attr_for_bulk_edit].each do |attr|
      eligible_params.merge!({ attr => params[:stored_file][attr] }) if params[:stored_file].has_key?(attr)
    end

    eligible_params
  end

  def eligible_flagging_attributes(stored_file, flag_ids, flagging_attributes)
    eligible_flaggings = {}

    flagging_attributes.each do |key, flagging|
      if flag_ids.include?(flagging[:flag_id]) #we've found an eligible flagging

        #we must find the flagging.id for the stored_file
        #and it include it in the params so it can be updated or destroyed
        flagging_id = stored_file.find_flagging_id_by_flag_id(flagging[:flag_id]) 

        #There are 4 scenarios here:
        # if stored file has flag (flagging_id is present):
        # -- if destroy is "1":
        # ---- flag is deleted, with merged params (Delete)
        # -- if destroy is "0":
        # ---- flag is updated, flagging[:id] is set to flagging_id, with merged params (Update)
        # if stored file does not have flag:
        # -- if destroy is "1":
        # ---- nothing is done, params are not merged (Ignore for this stored file)
        # -- if destroy is "0":
        # ---- flag is created, with merged params (Create)
        
        #flagging_id wont be found when stored file doesn't have the flag set
        #This would create a new flagging
        flagging[:id] = flagging_id if flagging_id.present?

        if !(flagging_id.nil? && flagging["_destroy"] == "1")
          eligible_flaggings.merge!({key => flagging})
        end
      end
    end

    {"flaggings_attributes" => eligible_flaggings}
  end

  def eligible_group_attributes(stored_file, group_ids, group_attributes)
    eligible_groups = {}

    group_attributes.each do |key, group|
      if group_ids.include?(group[:group_id])

        #We must find group_stored_files_id for the specific stored_file
        #so it can be updated or destroyed accordingly
        groups_stored_files_id = stored_file.find_groups_stored_files_id_by_group_id(group[:group_id])

        #There are 4 scenarios here:
        # if stored file has group (groups_stored_files_id is present):
        # -- if destroy is "1":
        # ---- group assignment is deleted, with merged params (Delete)
        # -- if destroy is "0":
        # ---- group assignment is updated, group[:id] is set to groups_stored_files_id, with merged params (Update)
        # if stored file does not have group:
        # -- if destroy is "1":
        # ---- nothing is done, params are not merged (Ignore for this stored file)
        # -- if destroy is "0":
        # ---- group assignment is created, with merged params (Create)
        
        #groups_stored_files_id won't be found when stored file doesn't have this group set
        #This would create a new group
        group[:id] = groups_stored_files_id if groups_stored_files_id.present?

        if !(groups_stored_files_id.nil? && group["_destroy"] == "1")
          eligible_groups.merge!({key => group})
        end
      end
    end

    {"groups_stored_files_attributes" => eligible_groups}
  end

end
