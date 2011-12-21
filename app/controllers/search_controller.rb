class SearchController < ApplicationController
  require 'will_paginate/array'
  helper_method :sort_column, :sort_direction, :per_page
  include ApplicationHelper

  def index
    date_params = {}
    [:original_date, :created_at].each do |date_type|
      [:start_date, :end_date].each do |p|
        date_params["#{date_type}_#{p}"] = build_date_from_string_safe(params["#{date_type}_#{p}"])
      end
    end
   
    @search = Sunspot.search(StoredFile) do
      if params.has_key?(:search)
        fulltext params[:search] do
          query_phrase_slop 1 
        end
      end

      [:flag_ids, :mime_type_id, :mime_type_category_id, :license_id,
        :indexed_collection_list, :batch_id, :indexed_tag_list, :user_id].each do |facet|
        if params.has_key?(facet)
          if params[facet].is_a?(Array)
            params[facet].each { |t| with facet, t }
          else
            with facet, CGI.unescape(params[facet])
          end
        end
      end

      [:copyright_holder, :author, :contributor_name].each do |text_facet|
        unless params[text_facet].blank?
          fulltext(params[text_facet], :fields => [text_facet])
        end
      end

      facet :flag_ids, :mime_hierarchy, :license_id

      [:original_date, :created_at].each do |date_type|
        if date_params["#{date_type}_start_date"]
          with(date_type).greater_than date_params["#{date_type}_start_date"].beginning_of_day 
        end
        if date_params["#{date_type}_end_date"]
          with(date_type).less_than date_params["#{date_type}_end_date"].end_of_day 
        end
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

    # indexed tag list
    links = StoredFile.tag_list.inject([]) do |arr, tag|
      if !params[:indexed_tag_list] || !params[:indexed_tag_list].include?(tag.name)
        params[:indexed_tag_list] ||= []
        arr.push({
          :label => tag.name,
          :url => url_for(params.clone.merge({ :indexed_tag_list => params[:indexed_tag_list] + [tag.name] }))
        })
      end
      arr
    end
    @facets[:indexed_tag_list] = links if links.size > 0

    # flags
    links = @search.facet(:flag_ids).rows.inject([]) do |arr, row|
      if !params[:flag_ids] || !params[:flag_ids].include?(row.value.to_s)
        params[:flag_ids] ||= []
        arr.push({
          :label => Flag.facet_label(row.value),
          :url => url_for(params.clone.merge({ :flag_ids => params[:flag_ids] + [row.value] }))
        })
      end
      arr
    end
    @facets[:flag_ids] = links if links.size > 0

    # licenses
    links = @search.facet(:license_id).rows.inject([]) do |arr, row|
      if params[:license_id] != row.value.to_s
        arr.push({
          :label => License.facet_label(row.value),
          :url => url_for(params.clone.merge({ :license_id => row.value }))
        })
      end
      arr
    end
    @facets[:license_id] = links if links.size > 0

    # mime type hierarchy
    if !params.has_key?(:mime_type_id) 
      @mime_categories = []
      links = []
      @search.facet(:mime_hierarchy).rows.each do |row|
        (mime_type_category_id, mime_type_id) = row.value.split('-')

        next if !(mime_type_category_id.present? && mime_type_id.present?)
   
        if !params.has_key?(:mime_type_category_id) && !@mime_categories.include?(mime_type_category_id) 
          links.push({
            :label => MimeTypeCategory.facet_label(mime_type_category_id),
            :id => mime_type_category_id,
            :class => "mime_type_category_id"
          })
          @mime_categories << mime_type_category_id 
        end
        links.push({
          :label => "&nbsp;&nbsp;#{MimeType.facet_label(mime_type_id)}",
          :id => mime_type_id,
          :class => "mime_type_id"
        })
      end
      @facets[:mime_hierarchy] = links if links.size > 0
    end
  end

  def build_removeable_facets(params)
    facets_to_remove = {}
    @hidden_facets = {}

    removed_facets = ["search", "tag",
      "created_at_start_date", "created_at_end_date",
      "original_date_start_date", "original_date_end_date",
      "flag_ids", "license_id", "mime_type_id", "mime_type_category_id",
      "indexed_collection_list", "batch_id", "indexed_tag_list", "author",
      "contributor_name", "copyright_holder", "user_id"]

    params.each do |facet, value|
      if value.presence && removed_facets.include?(facet)
        @hidden_facets.merge!({ facet => value })
        facets_to_remove[facet] ||= []
        if value.is_a?(Array)
          params[facet].each do |v|
            t = params.clone
            t[facet] = t[facet].select{ |b| b != v }
            facets_to_remove[facet] << {
              :label => facet == "flag_ids" ? Flag.facet_label(v) : v,
              :url => url_for(t)
            }
           end
        else
          if ["license_id", "mime_type_id", "mime_type_category_id"].include?(facet)
            klass = facet.gsub(/_id$/, '').classify.constantize
            facets_to_remove[facet] << {
             :label => klass.facet_label(value),
             :url => url_for(params.clone.remove!(facet))
            }
          else 
            facets_to_remove[facet] << {
             :label => value,
             :url => url_for(params.clone.remove!(facet))
            }
          end
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
      "created_at_start_date" => "Created After",
      "created_at_end_date" => "Created Before",
      "original_date_start_date" => "Original Date After",
      "original_date_end_date" => "Original Date Before",
      "mime_type_category_id" => "File Type Category",
      "mime_type_id" => "File Type",
      "contributor_name" => "Contributor Name",
      "copyright_holder" => "Copyright Holder",
      "user_id" => "Contributor Id"
    }

    @removeable_facets = {}
    facets_to_remove.each do |k, v|
      if(label_map[k])
        @removeable_facets[label_map[k]] = v
      else
        @removeable_facets[k] = v
      end
    end

    if params.has_key?(:date_type)
      @hidden_facets.merge!({ :date_type => params[:date_type] })
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
      if hit.stored(:access_level_id).to_i == open.id
        filtered_results << hit 
      elsif current_user.present? && current_user.can_view_cached?(hit.stored(:id))
        filtered_results << hit 
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
