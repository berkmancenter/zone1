class SearchController < ApplicationController
  def index
	@search = Sunspot.new_search(StoredFile)
	@search.build do
		if params.has_key?(:tag)
			with :tag_list, CGI.unescape(params[:tag])
		end
		if params.has_key?(:aid)
			with :access_level_id, CGI.unescape(params[:aid])
		end
		if params.has_key?(:uid)
			with :user_id, CGI.unescape(params[:uid])
		end
		if params.has_key?(:cid)
			with :content_type_id, CGI.unescape(params[:cid])
		end
		if params.has_key?(:flag)
			with :flag_ids, CGI.unescape(params[:flag])
		end
		fulltext params[:search] do
			query_phrase_slop 1 
		end
		facet :file_size, :access_level_id, :user_id, :content_type_id, :flag_ids, :tag_list
		paginate :page => params[:page], :per_page => 30 
	end
	@search.execute!
	@storedfiles = @search.results
	@facets = []

    links = @search.facet(:tag_list).rows.inject([]) do |arr, row|
      remove = params[:tag] == row.value
      arr.push({
        :label => row.value.capitalize,
        :remove => remove,
        :url => remove ? url_for(params.clone.remove!(:tag)) : url_for(params.clone.merge({ :tag => row.value }))
      })
      arr
    end
    @facets.push({ :label => "Tags", :links => links })
	
	links = @search.facet(:user_id).rows.inject([]) do |arr, row|
      remove = params[:uid].to_i == row.value
      arr.push({
        :label => User.find(row.value).name,
        :remove => remove,
        :url => remove ? url_for(params.clone.remove!(:uid)) : url_for(params.clone.merge({ :uid => row.value }))
      })
      arr
    end
    @facets.push({ :label => "Users", :links => links })

	links = @search.facet(:access_level_id).rows.inject([]) do |arr, row|
      remove = params[:aid].to_i == row.value
      arr.push({
        :label => AccessLevel.find(row.value).label,
        :remove => remove,
        :url => remove ? url_for(params.clone.remove!(:aid)) : url_for(params.clone.merge({ :aid => row.value }))
      })
      arr
    end
    @facets.push({ :label => "Access Levels", :links => links })

	links = @search.facet(:content_type_id).rows.inject([]) do |arr, row|
      remove = params[:cid].to_i == row.value
      arr.push({
        :label => ContentType.find(row.value).name.capitalize,
        :remove => remove,
        :url => remove ? url_for(params.clone.remove!(:cid)) : url_for(params.clone.merge({ :cid => row.value }))
      })
      arr
    end
    @facets.push({ :label => "Content Type", :links => links })

	links = @search.facet(:flag_ids).rows.inject([]) do |arr, row|
      remove = params[:flag].to_i == row.value
      arr.push({
        :label => Flag.find(row.value).label,
        :remove => remove,
        :url => remove ? url_for(params.clone.remove!(:flag)) : url_for(params.clone.merge({ :flag => row.value }))
      })
      arr
    end
    @facets.push({ :label => "Flags", :links => links })


  end
end
