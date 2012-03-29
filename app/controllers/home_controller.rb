class HomeController < ApplicationController
  require_or_load File.join(Rails.root, "lib", "zone1", "sunspot_search") # auto load lib changes
  include Zone1::SunspotSearch

  def index
    @search = build_stored_file_search
    build_removable_facets(params)
    build_searchable_facets(params, @search)
  end
end
