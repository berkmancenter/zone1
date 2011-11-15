class BulkEditsController < ApplicationController

  include ApplicationHelper

  def new
    if params[:stored_file_ids].is_a?(Array) && params[:stored_file_ids].length > 1
      @stored_files = StoredFile.find(params[:stored_file_ids])
      matching_attributes = StoredFile.matching_attributes_from(@stored_files)
      @stored_file = StoredFile.new(matching_attributes)
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

      eligible_params = {}
      params[:attr_for_bulk_edit].each do |attr|
        eligible_params.merge!({ attr => params[:stored_file][attr] }) if params[:stored_file].has_key?(attr)
      end

      
      stored_files.each do |stored_file|
        stored_file.custom_save(eligible_params, current_user)
      end

      
      
      flag_ids = params[:attr_for_bulk_edit].select{ |attr| attr.is_a?(Hash) && attr.has_key?("flag_ids") }
      
      update_flaggings(stored_files, flag_ids) if flag_ids
    
      redirect_to search_path
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

  def update_flaggings(stored_files, flag_ids)
    if params[:stored_file].has_key?("flaggings_attributes") 
      stored_files.each do |stored_file|
        stored_file.flaggings.each do |flaggings|
          
          #TODO determine how flaggings are to be handled in bulk edit

        end                   
      end
    end
  end
end
