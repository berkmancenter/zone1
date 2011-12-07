class SearchController < ApplicationController
  require 'will_paginate/array'
  helper_method :sort_column, :sort_direction, :per_page
  include ApplicationHelper

  def label_author(value)
    value == '' ? 'empty string' : value
  end
  def label_office(value)
    value == '' ? 'empty string' : value
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
    params.each do |k, v|
      if !v.presence
        params.delete(k)
      end
    end

    # splits keywords into multiple facets if not quoted
    if params.has_key?(:search)
      last = params[:search].pop
      if !last.match('"')
        params[:search] += last.split(' ')
      end
    end

    #must setup both instance and local variables, so @search.build can access
    @start_date = start_date = build_date_from_string_safe(params[:start_date])
    @end_date = end_date = build_date_from_string_safe(params[:end_date])
   
    @search = Sunspot.new_search(StoredFile)
    @search.build do
      if params.has_key?(:search)
        fulltext params[:search] do
          query_phrase_slop 1 
        end
      end

      [:flag_ids, :mime_type_id, :mime_type_category_id, :license_id, :indexed_collection_list, :batch_id].each do |facet|
        if params.has_key?(facet)
          if params[facet].is_a?(Array)
            params[facet].each { |t| with facet, t }
          else
            with facet, CGI.unescape(params[facet])
          end
        end
      end

      facet :flag_ids, :mime_hierarchy, :license_id

      if params[:people].present?
        params[:people_type] ||= "author"
        with(params[:people_type].to_sym, params[:people])
      end

      if start_date && end_date
        params[:date_type] ||= "created_at"
        with(params[:date_type].to_sym, start_date.beginning_of_day..end_date.end_of_day) 
      end

      order_by sort_column, sort_direction 
    end

    @search.execute!
    @hits = filter_and_paginate_search_results(@search)

    build_removeable_facets(params)

    build_searchable_facets(params)
  end

  def build_searchable_facets(params)
    @facets = {}

    [:flag_ids, :license_id].each do |facet|
      links = @search.facet(facet).rows.inject([]) do |arr, row|
        if StoredFile::FACETS_WITH_MULTIPLE.include?(facet)
          if !params[facet] || !params[facet].include?(row.value.to_s)
            params[facet] ||= []
            arr.push({
              :label => self.send("label_#{facet.to_s}", row.value),
              :url => url_for(params.clone.merge({ facet => params[facet] + [row.value] }))
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

    if !params.has_key?(:mime_type_id) 
      @mime_categories = []
      links = []
      @search.facet(:mime_hierarchy).rows.each do |row|
        (mime_type_category_id, mime_type_id) = row.value.split('-')

        next if !(mime_type_category_id.present? && mime_type_id.present?)
   
        if !params.has_key?(:mime_type_category_id) && !@mime_categories.include?(mime_type_category_id) 
          links.push({
            :label => self.label_mime_type_category_id(mime_type_category_id),
            :id => mime_type_category_id,
            :class => "mime_type_category_id"
          })
          @mime_categories << mime_type_category_id 
        end
        links.push({
          :label => "&nbsp;&nbsp;#{self.label_mime_type_id(mime_type_id)}",
          :id => mime_type_id,
          :class => "mime_type_id"
        })
      end
      @facets[:mime_hierarchy] = links if links.size > 0
    end
  end

  def build_removeable_facets(params)
    @removeable_facets = {}
    @hidden_facets = {}

    removed_facets = ["search", "tag", "start_date", "end_date", "people",
      "flag_ids", "license_id", "mime_type_id", "mime_type_category_id",
      "indexed_collection_list", "batch_id"]

    params.each do |facet, value|
      if value.presence && removed_facets.include?(facet)
        @hidden_facets.merge!({ facet => value })
        @removeable_facets[facet] ||= []
        if value.is_a?(Array)
          params[facet].each do |v|
            t = params.clone
            t[facet] = t[facet].select{ |b| b != v }
            @removeable_facets[facet] << {
              :label => self.respond_to?("label_#{facet.to_s}", v) ? self.send("label_#{facet.to_s}", v) : v,
              :url => url_for(t)
            }
           end
       else
        @removeable_facets[facet] << {
          :label => self.respond_to?("label_#{facet.to_s}", value) ? self.send("label_#{facet.to_s}", value) : value,
          :url => url_for(params.clone.remove!(facet))
        }
        end
      end
    end

    label_map = {
      "search" => "Keyword",
      "indexed_tag_list" => "Tag",
      "license_id" => "License",
      "indexed_collection_list" => "Collection Name",
      "flag_ids" => "Flags",
      "batch_id" => "Batch",
      "start_date" => "#{params[:date_type]} Start Date",
      "end_date" => "#{params[:date_type]} End Date",
      "people" => "#{params[:people_type]}",
      "mime_type_category_id" => "File Type Category",
      "mime_type_id" => "File Type"
    }
    @removeable_facets.each do |k, v|
      if(label_map[k])
        @removeable_facets[label_map[k]] = v
        @removeable_facets.delete(k)
      end
    end
  end

  private

  # Private method for filtering and paginating search results
  # Working directly with search.hits minimizes the requirement to access
  # stored file object, and eliminates object instantiation
  def filter_and_paginate_search_results(search)
    filtered_results = []

    open = AccessLevel.open
    search.hits.each do |hit|
      if current_user
        filtered_results << hit if User.can_view_cached?(hit.stored(:id), current_user)
      else
        filtered_results << hit if hit.stored(:access_level_id) == open.id
      end
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
