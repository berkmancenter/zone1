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
   
    facets = [:batch_id, :indexed_collection_list, :author, :office, :user_id, :indexed_tag_list, :flag_ids, :license_id, :mime_type_id, :mime_type_category_id]
    @search = Sunspot.new_search(StoredFile)
    @search.build do
      facets.each do |facet|
        if params.has_key?(facet)
          if params[facet].is_a?(Array)
            params[facet].each { |t| with facet, t }
          else
            with facet, CGI.unescape(params[facet])
          end
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

    @removeable_facets = {}
    facets.each do |facet|
      if params.has_key?(facet)
        @removeable_facets[facet] ||= []
        if params[facet].is_a?(Array)
          params[facet].each do |v|
            t = params.clone
            t[facet] = t[facet].select{ |b| b != v }
            @removeable_facets[facet] << {
              :label => self.send("label_#{facet.to_s}", v),
              :url => url_for(t)
            }
           end
         else
          @removeable_facets[facet] << {
            :label => self.send("label_#{facet.to_s}", params[facet]),
            :url => url_for(params.clone.remove!(facet))
          }
        end  
      end 
    end

    @facets = {}
    [:flag_ids, :mime_type_category_id, :license_id].each do |facet|
      links = @search.facet(facet).rows.inject([]) do |arr, row|
        if StoredFile::FACETS_WITH_MULTIPLE.include?(facet)
          if !params[facet] || !params[facet].include?(row.value.to_s)
            t = params.clone
            t[facet] ||= []
            t[facet] << row.value
            arr.push({
              :label => self.send("label_#{facet.to_s}", row.value),
              :url => url_for(t)
            })
          end
        else
          if params[facet] != row.value.to_s
            arr.push({
              :label => self.send("label_#{facet.to_s}", row.value),
              :url => url_for(params.clone.merge({ facet => row.value }))
            })
          end
        end
        arr
      end
      @facets[facet] = links if links.size > 0
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
    session[:per_page] = params[:per_page] || session[:per_page] || "10"
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
