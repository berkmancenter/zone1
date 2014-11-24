require 'csv'

class BulkEditsController < ApplicationController
  include ApplicationHelper
  add_breadcrumb "current search", :search_path

  def new
    if !params[:stored_file_ids].is_a?(Array)
      redirect_to search_path
    end

    # This wonky looking logic supports the CSV Edit feature and the normal bulk edit feature
    respond_to do |format|
      format.html do
        if params[:stored_file_ids].length > 1
          prepare_bulk_edits
        elsif params[:stored_file_ids].length == 1
          redirect_to edit_stored_file_path(params[:stored_file_ids].first)
        end
      end
      format.csv do
        @stored_files = StoredFile.find(params[:stored_file_ids])
        @stored_files.each {|f| f.accessible = StoredFile::ALLOW_CSV_ATTRIBUTES}
      end
    end
  end

  def prepare_bulk_edits
      @stored_files = StoredFile.find(params[:stored_file_ids])

      @attr_accessible = BulkEdit.bulk_editable_attributes(@stored_files, current_user)
      matching_attributes = BulkEdit.matching_attributes_from(@stored_files)      
      matching_attributes =  matching_attributes.select {|k, v| @attr_accessible.include?(k.to_sym) }   
    
      @stored_file = StoredFile.new
      #must define accessible before setting attributes
      @stored_file.accessible = @attr_accessible + [:user_id, :batch_id]
      @stored_file.attributes = matching_attributes
      @stored_file.build_bulk_flaggings_for(@stored_files, current_user)
      @stored_file.build_bulk_groups_for(@stored_files, current_user)

      @licenses = License.all
      add_breadcrumb "edit #{@stored_files.map(&:original_filename).join(", ")}", new_bulk_edit_path(params)
  end

  def csv_edit
    begin
      entries = {}
      CSV.foreach(params[:file].tempfile.path, :col_sep => ',', :headers => true) do |row|
        attributes = row.to_hash
        entries[ attributes['id'] ] = attributes
      end

      stored_files = StoredFile.find(entries.keys)
      stored_file_id = nil
      StoredFile.transaction do
        stored_files.each do |stored_file|
          stored_file_id = stored_file.id.to_s
          file_params = entries[stored_file_id]

          # access_level_label and flaggings get special handling/validation
          access_level_label = file_params.delete 'access_level_label'
          if access_level_label
            access_level_id = AccessLevel.find_by_label(access_level_label).try(:id)
            file_params[:access_level_id] = access_level_id if access_level_id
          end

          file_params[:flaggings_attributes] = merge_flaggings_attributes(stored_file, file_params)

          # Build list of accessible attributes for this stored file to avoid sending
          # any disallowed params and raising an exception
          attr_accessible = stored_file.attr_accessible_for(file_params, current_user)
          allowed_attrs = StoredFile::ALWAYS_ACCESSIBLE_ATTRIBUTES.dup
          allowed_attrs += (StoredFile::ALLOW_CSV_ATTRIBUTES & attr_accessible)

          # ALLOW_CSV_ATTRIBUTES will never have :access_level_id (for CSV export reasons) but it is 
          # allowed here if it is present in attr_accessible (as we would always expect it to be.)
          allowed_attrs += [:access_level_id] if attr_accessible.include?(:access_level_id)

          attributes = file_params.select {|k, v| allowed_attrs.include?(k.to_sym)}
          stored_file.custom_save(attributes, current_user)
        end
      end

      render :json => { :success => true }
    rescue Exception => e
      render :json => { :success => false, :message => e.to_s, :stored_file_id => stored_file_id }
      log_exception e
    end
  end

  def create

    begin 
      if !params.has_key? :attr_for_bulk_edit
        raise "Please select items to update."
      end

      stored_files = StoredFile.find(params[:stored_file_ids])

      # Run the bulk edit inside a transaction because if one save completes but
      # another fails, all changes should be rolled back. This also covers issues 
      # clearing flaggings or groups.
      StoredFile.transaction do
        # Does not include flaggings or groups.
        # These must be customized for each stored file.
        eligible_params = eligible_params_for_bulk_edit

        stored_files.each do |stored_file|
          # Always start with same base
          stored_file_params = eligible_params.clone 

          # Customize flaggings and groups per stored file
          stored_file_params.merge! flaggings_attributes_for(stored_file)
          stored_file_params.merge! groups_attributes_for(stored_file)
          stored_file.custom_save(stored_file_params, current_user)
        end

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

  def merge_flaggings_attributes(stored_file, file_params)
    @flag_hash ||= Flag.all.inject({}) { |memo, f| memo[f.label] = f; memo }

    current_flaggings = stored_file.flaggings.inject({}) do |array, flagging|
      array[flagging.flag_id.to_s] = flagging.attributes
      array
    end
    # Build flaggings hash for each flag to generate the same hash that custom_save
    # sees when flag_hash are modified through the web edit UI
    @flag_hash.each do |label, flag|
      flag_id = flag.id.to_s
      flag_value = file_params[label].downcase.strip

      current_flaggings[flag_id] ||= {'flag_id' => flag_id, 'user_id' => current_user.id.to_s}
      current_flaggings[flag_id]['_destroy'] = flag_value == 'true' ? '0' : '1'
    end

    current_flaggings
  end

  def flaggings_attributes_for(stored_file)
    flagging_attributes = {}
    params[:attr_for_bulk_edit].each do |attr|
      if attr.is_a?(Hash) 
        if attr.has_key?("flag_ids") && params[:stored_file].has_key?("flaggings_attributes")
          flagging_attributes.merge! eligible_flagging_attributes(
              stored_file,
              attr[:flag_ids],
              params[:stored_file][:flaggings_attributes]
            )
        end
      end
    end
    flagging_attributes
  end

  def groups_attributes_for(stored_file)
    group_attributes = {}
    params[:attr_for_bulk_edit].each do |attr|
      if attr.is_a?(Hash) 
        if attr.has_key?("group_ids") && params[:stored_file].has_key?("groups_stored_files_attributes")
          group_attributes.merge! eligible_group_attributes(
              stored_file,
              attr[:group_ids],
              params[:stored_file][:groups_stored_files_attributes]
            )
        end
      end
    end
    group_attributes
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
      #if this flagging is eligible
      if flag_ids.include?(flagging[:flag_id]) 

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
        
        #flagging_id needs to be set to nil if new record, or existing flagging id
        flagging[:id] = flagging_id 
        flagging[:user_id] = current_user.id
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

        #Find group_stored_files_id for the specific stored_file
        #so it can be updated or destroyed accordingly
        gsf = GroupsStoredFile.where(:group_id => group[:group_id], :stored_file_id => stored_file.id).limit(1)
        groups_stored_files_id = gsf.try(:first).try(:id)

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
        
        #group id needs to be set to nil if new record, or existing group assignment id
        group[:id] = groups_stored_files_id

        if !(groups_stored_files_id.nil? && group["_destroy"] == "1")
          eligible_groups.merge!({key => group})
        end
      end
    end
    {"groups_stored_files_attributes" => eligible_groups}
  end

end
