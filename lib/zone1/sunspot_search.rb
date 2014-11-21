require 'active_support/concern'

# Restart application after modifying this file
# or add require_or_load File.join(Rails.root, "lib", "zone1", "sunspot_search")
# to files using this module

module Zone1
  module SunspotSearch
    extend ActiveSupport::Concern

    included do
      # class level code
      # before_filter ....
    end

    module ClassMethods
      # all class methods here
    end

    def build_stored_file_search
      Sunspot.search(StoredFile) do
        if params.has_key?(:search)
          fulltext params[:search] do
            query_phrase_slop 1 
          end
        end

        # Implements case insensitive string fields from StoredFile's searchable block
        downcased_facets = {
          :indexed_tag_list => :indexed_tag_list_downcase,
          :indexed_collection_list => :indexed_collection_list_downcase
        }

        [:flag_ids, :mime_type_id, :mime_type_category_id, :license_id,
         :batch_id, :indexed_tag_list, :indexed_collection_list, :user_id].each do |facet|
          if params.has_key?(facet)
            if params[facet].is_a?(Array)
              params[facet].each do |t|
                if downcased_facets[facet]
                  with(downcased_facets[facet], t.downcase)
                else
                  with(facet, t)
                end
              end
            else
              if downcased_facets[facet]
                with(downcased_facets[facet], CGI.unescape(params[facet].downcase))
              else
                with(facet, CGI.unescape(params[facet]))
              end
            end
          end
        end

        [:author, :contributor_name, :copyright_holder].each do |text_facet|
          if !params[text_facet].blank?
            fulltext(params[text_facet], :fields => [text_facet])
          end
        end

        facet :flag_ids, :mime_hierarchy, :license_id

        date_params = {}
        [:original_date, :created_at].each do |date_type|
          [:start_date, :end_date].each do |p|
            date_params["#{date_type}_#{p}"] = build_date_from_string_safe(params["#{date_type}_#{p}"])
          end
        end
       
        # original date is a date, and created_at is a timestamp
        [:created_at].each do |date_type|
          if date_params["#{date_type}_start_date"]
            with(date_type).greater_than date_params["#{date_type}_start_date"].beginning_of_day 
          end
          if date_params["#{date_type}_end_date"]
            with(date_type).less_than date_params["#{date_type}_end_date"].end_of_day 
          end
        end
        [:original_date].each do |date_type|
          if date_params["#{date_type}_start_date"]
            with(date_type).greater_than date_params["#{date_type}_start_date"]
          end
          if date_params["#{date_type}_end_date"]
            with(date_type).less_than date_params["#{date_type}_end_date"] 
          end
        end

        # Excluded deleted files
        with(:complete, false) if params[:complete] == "0"

        paginate :page => 1, :per_page => StoredFile.count
        order_by sort_column, sort_direction
      end
    end #build stored_file_search
  
    def build_searchable_facets(params, search)
      @facets = {}

      # indexed tag list
      links = Tag.tag_list.inject([]) do |arr, tag|
        if !params[:indexed_tag_list] || !params[:indexed_tag_list].include?(tag.name)
          params[:indexed_tag_list] ||= []
          arr.push({
            :label => tag.name,
            :url => url_for(params.clone.merge({:page => nil, :indexed_tag_list => params[:indexed_tag_list] + [tag.name], :controller => 'search' }))
          })
        end
        arr
      end
      @facets[:indexed_tag_list] = links unless links.empty?

      # licenses
      links = search.facet(:license_id).rows.inject([]) do |arr, row|
        if params[:license_id] != row.value.to_s
          arr.push({
            :label => License.facet_label(row.value),
            :url => url_for(params.clone.merge({ :license_id => row.value, :controller => :search }))
          })
        end
        arr
      end
      @facets[:license_id] = links unless links.empty?

      # mime type hierarchy
      facet_mime_types(params, search)
    end

    def facet_mime_types(params, search)
      # Refactored from original implementation to use the cached mime type list
      # and to create a simplified data structure (all zone1 objects) for the view. 
      # This type of refactoring could be done elsewhere as well, but it is a low
      # priority.
      # Note that there is some quirkiness with how Zone1 decides to show all known
      # file types in the File Type search box, versus just the files types it has
      # content for. More testing is probably required to help figure out what the
      # user expects to see in those situations.
      show_all = params.has_key?(:mime_type_id)  #what was this supposed to do?

      mtc_facets = {}
      mt_facets = {}
      # Build list of mtc and mt IDs from the search facets
      if !show_all
        mime_pairs = search.facet(:mime_hierarchy).rows.map(&:value)
        mime_pairs.each do |pair|
          (mime_type_category_id, mime_type_id) = pair.split('-')
          next if mime_type_category_id.nil? || mime_type_id.nil?

          mtc_facets[mime_type_category_id.to_i] = true
          mt_facets[mime_type_id.to_i] = true
        end
      end

      links = []
      # Build list of MimeTypeCategory and MimeType objects, possibly filtering them
      # down to the ones the current search facet wants to see.
      MimeTypeCategory.cached_mime_type_tree.each do |obj|
        if obj.is_a?(MimeTypeCategory) && !params.has_key?(:mime_type_category_id)
          links << obj if show_all || mtc_facets[obj.id]
        elsif obj.is_a? MimeType
          links << obj if show_all || mt_facets[obj.id]
        end
      end

      @facets[:mime_hierarchy] = links unless links.empty?
    end

    def build_removable_facets(params)
      # Build facets that show up in "current search" of search filter box with
      # a remove_link "X" proceeding them. Also build hidden form elements that persist
      # those removable facets within the search form
      facets_to_remove = {}
      @hidden_facets = {}

      removed_facets = %w( search tag
        created_at_start_date created_at_end_date
        original_date_start_date original_date_end_date
        flag_ids license_id mime_type_id mime_type_category_id
        indexed_collection_list batch_id indexed_tag_list author
        contributor_name copyright_holder user_id complete )

      params.each do |facet, value|
        if value.presence && removed_facets.include?(facet)
          # Checkboxes persist in the form so we don't need them as a hidden facets
          @hidden_facets.merge!({ facet => value }) unless (facet == 'flag_ids' || facet == 'complete')
          facets_to_remove[facet] ||= []
          if value.is_a?(Array)
            params[facet].each do |v|
              t = params.clone
              t[facet] = t[facet].select{ |b| b != v }
              facets_to_remove[facet] << {
                :label => facet == 'flag_ids' ? Flag.facet_label(v) : v,
                :url => url_for(t)
              }
             end
          else
            if %w( license_id mime_type_id mime_type_category_id ).include?(facet)
              klass = facet.gsub(/_id$/, '').classify.constantize
              label = klass.facet_label(value)
            else
              label = value
            end
            facets_to_remove[facet] << {
               :label => label,
               :url => url_for(params.clone.remove!(facet))
            }
          end
        end
      end

      if params.has_key?(:date_type)
        @hidden_facets.merge!({ :date_type => params[:date_type] })
      end

      # Make nice, readable labels for current search facets
      label_map = {
        "search" => "Keyword",
        "indexed_tag_list" => "Tag",
        "license_id" => "License",
        "indexed_collection_list" => "Collection",
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
        "user_id" => "Contributor Id",
        "complete" => "Incomplete Files Only"
      }

      # Further tweak some labels/values to make them a little friendlier
      facets_to_remove['complete'].first[:label] = 'yes' if facets_to_remove['complete']

      # Show friendlier facet label/value than "Contributor ID: 42" for 'only my files' 
      # but only if user_id = the logged in user.
      if facets_to_remove['user_id']
        if current_user.try(:id).to_s == facets_to_remove['user_id'].first[:label]
          facets_to_remove['user_id'].first[:label] = 'yes'
          label_map['user_id'] = 'Only My Files'
        end
      end
      
      @removable_facets = {}
      facets_to_remove.each do |k, v|
        @removable_facets[ label_map[k] || k ] = v
      end
      
    end  #build_removable facets

    def per_page
      params[:per_page] = "10" if params[:per_page].to_i == 0
      session[:per_page] = params[:per_page] || session[:per_page] || "10"
    end

    def sort_column
      session[:sort_column] = params[:sort_column] || session[:sort_column] || "created_at"
    end

    def sort_direction
      direction = params[:sort_direction] || session[:sort_direction]
      session[:sort_direction] = %w(asc desc).include?(direction) ? direction : "desc"
    end


    private

    # Working directly with search.hits minimizes the requirement to access
    # stored file object, and eliminates object instantiation
    def filter_search_results(search)
      open_id = AccessLevel.open.id

      #BOOP: what if we could send can_view_cached? a list of stored_file ids?
      search.hits.select do |hit|
        hit.stored(:access_level_id).to_i == open_id || current_user.try(:can_view_cached?, hit.stored(:id))
      end
    end

  end #module sunspot search
end #module zone1
