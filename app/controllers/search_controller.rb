class SearchController < ApplicationController
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
    User.find(value).name
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
    facets = [:batch_id, :collection_list, :author, :office, :user_id, :tag_list, :flag_ids, :license_id, :format_name] #:copyright
	@search = Sunspot.new_search(StoredFile)
	@search.build do
        facets.each do |facet|
          if params.has_key?(facet)
			with facet, CGI.unescape(params[facet])
          end
        end
		fulltext params[:search] do
			query_phrase_slop 1 
		end
        facet :batch_id, :collection_list, :author, :office, :user_id, :tag_list, :flag_ids, :license_id, :format_name #:copyright
		paginate :page => params[:page], :per_page => 30 
	end
	@search.execute!
	@stored_files = @search.results
	@facets = []

    facets.each do |facet|
      links = @search.facet(facet).rows.inject([]) do |arr, row|
        remove = (params[facet] == row.value)
        arr.push({
          :label => self.send("label_#{facet.to_s}", row.value),
          :remove => remove,
          :url => remove ? url_for(params.clone.remove!(facet)) : url_for(params.clone.merge({ facet => row.value }))
        })
        arr
      end
      @facets.push({ :label => facet.to_s, :links => links })
    end

	@access_levels = AccessLevel.all
    @flags = Flag.all
  end
end
