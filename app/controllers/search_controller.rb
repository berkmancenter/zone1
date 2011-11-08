class SearchController < ApplicationController

  helper_method :sort_column, :sort_direction, :per_page
  include ApplicationHelper

 
  def label_batch_id(value)
    value
  end
  def label_collection_list(value)
    value
  end
  def label_author(value)
    value == '' ? 'empty string' : value
  end
  def label_office(value)
    value == '' ? 'empty string' : value
  end
  def label_user_id(value)
    user = User.find_by_id(value)
    user.present? ? user.name : "Unknown user"
  end
  def label_tag_list(value)
    value
  end
  def label_flag_ids(value)
    Flag.find(value).label
  end
  def label_license_id(value)
    License.find(value).name
  end
  def label_format_name(value)
    "label"
  end
  
  def index

    @flags = Flag.all
    @access_levels = AccessLevel.all
    
    unless params[:commit] == "clear"
      #must setup both instance and local variables
      @created_at_start_date = created_at_start_date = build_date_from_string_safe(params[:created_at_start_date]) #for filter partial
      @created_at_end_date = created_at_end_date = build_date_from_string_safe(params[:created_at_end_date]) #for inside @search.build block
    end

   
    facets = [:batch_id, :collection_list, :author, :office, :user_id, :tag_list, :flag_ids, :license_id, :format_name] #:copyright
    @search = Sunspot.new_search(StoredFile)
    @search.build do
      facets.each do |facet|
        if params.has_key?(facet)
          with facet, CGI.unescape(params[facet])
        end
      end

      # TODO: Figure out what this is for (Steph)
      fulltext params[:search] do
        query_phrase_slop 1 
      end
      facet :batch_id, :collection_list, :author, :office, :user_id, :tag_list, :flag_ids, :license_id, :format_name #:copyright
      with(:created_at, created_at_start_date.beginning_of_day..created_at_end_date.end_of_day) if created_at_start_date && created_at_end_date
      paginate :page => params[:page], :per_page => per_page
      order_by sort_column, sort_direction 
    end
    @search.execute!
    @stored_files = @search.results
    @facets = []

    facets.each do |facet|
      links = @search.facet(facet).rows.inject([]) do |arr, row|
        remove = (params[facet] == row.value.to_s)
        arr.push({
          :label => self.send("label_#{facet.to_s}", row.value),
          :remove => remove,
          :url => remove ? url_for(params.clone.remove!(facet)) : url_for(params.clone.merge({ facet => row.value }))
        })
        arr
      end
      @facets.push({ :label => facet.to_s, :links => links })
    end
  end

  private

  def per_page
    session[:per_page] = params[:per_page] || session[:per_page] || "30"
  end

  def sort_column
    column = params[:sort_column] || session[:sort_column]
    if StoredFile.column_names.include?(column)
      session[:sort_column] = column
    else
      "created_at"
    end
  end

  def sort_direction
    direction = params[:sort_direction] || session[:sort_direction]
    if %w(asc desc).include?(direction)
      session[:sort_direction] = direction
    else
      "desc"
    end
  end
end
