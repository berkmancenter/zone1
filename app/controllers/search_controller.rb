class SearchController < ApplicationController
  require 'will_paginate/array'
  require_or_load File.join(Rails.root, "lib", "zone1", "sunspot_search") # auto load lib changes
  include ApplicationHelper
  include Zone1::SunspotSearch
  helper_method :sort_column, :sort_direction, :per_page
  
  def index 
    @search = build_stored_file_search
    @search.execute!
    @all_hits = filter_search_results(@search)
    @hits = @all_hits.paginate(:page => params[:page], :per_page => per_page)
    @hit_ids_on_other_pages = (@all_hits.collect { |hit| hit.stored(:id) }) - (@hits.collect { |hit| hit.stored(:id) })
    @export_dash_collections = current_user ? current_user.dash_collections : []
    
    build_removable_facets(params)
    build_searchable_facets(params, @search)
  end

  def tags
    tag_list = Tag.all
    tag_list = tag_list.select{ |t| t.name.downcase.include?(params[:term].downcase) } if params[:term]
    render :json => tag_list.map(&:name) 
  end

  private
  
  def dash_export_collections
    Array.wrap(current_user ? Dash.collections_by_user_id(current_user.id) : nil)
  end
end
