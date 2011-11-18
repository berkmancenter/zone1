class SearchController < ApplicationController
  require 'will_paginate/array'
  helper_method :sort_column, :sort_direction, :per_page
  include ApplicationHelper

  def label_batch_id(value)
    value
  end
  def label_indexed_collection_list(value)
    value
  end
  def label_author(value)
    value == '' ? 'empty string' : value
  end
  def label_office(value)
    value == '' ? 'empty string' : value
  end
  def label_user_id(value)
    # TODO: This is hitting the database. can_optimize? yes
    User.name_map[value] || "Unknown user"
  end
  def label_indexed_tag_list(value)
    value
  end
  def label_flag_ids(value)
    # Original code:
    # Flag.find(value).label

    # TODO: Possibly find a more elegant performance optimization
    # This is an optimization because Flag.all is cached,
    # but it's not very elegant IMO. The goal is to minimize lookup
    # of flags on every search.
    Flag.label_map[value.to_s]
  end
  def label_license_id(value)
    # TODO: See label_flag_ids
    License.name_map[value.to_s]
  end
  def label_mime_type_id(value)
    MimeType.find(value).name
  end
  def label_mime_type_category_id(value)
    MimeTypeCategory.find(value).name
  end
  
  def index
    unless params[:commit] == "clear"
      #must setup both instance and local variables, so @search.build can access
      @created_at_start_date = created_at_start_date = build_date_from_string_safe(params[:created_at_start_date]) #for filter partial
      @created_at_end_date = created_at_end_date = build_date_from_string_safe(params[:created_at_end_date]) #for inside @search.build block
    end
   
    facets = [:batch_id, :indexed_collection_list, :author, :office, :user_id, :indexed_tag_list, :flag_ids, :license_id, :mime_type_id, :mime_type_category_id] #:copyright
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
      facet :batch_id, :indexed_collection_list, :author, :office, :user_id, :indexed_tag_list, :flag_ids, :license_id, :mime_type_id, :mime_type_category_id  #:copyright
      with(:created_at, created_at_start_date.beginning_of_day..created_at_end_date.end_of_day) if created_at_start_date && created_at_end_date
      order_by sort_column, sort_direction 
    end
    @search.execute!
    @hits = filter_and_paginate_search_results(@search)

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

  # Private method for filtering and paginating search results
  # Working directly with search.hits minimizes the requirement to access
  # stored file object, and eliminates object instantiation
  def filter_and_paginate_search_results(search)
    filtered_results = []

    search.hits.each do |hit|
      filtered_results << hit if User.can_view_cached?(hit.stored(:id), current_user)
    end

    filtered_results.paginate :page => params[:page], :per_page => per_page
  end

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
