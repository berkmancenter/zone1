module StoredFilesHelper
  def editable_field(f, attrs, field, options, type, label="")
      render :partial => "stored_files/editable_field",
             :locals => { :form => f,
               :attrs => attrs,
               :field => field,
               :options => options,
               :type => type, 
               :label => label.presence || field }
  end

  def bulk_edit(attr)
    check_box_tag("attr_for_bulk_edit[]", attr) if bulk_edit?
  end

  def bulk_edit?
    params[:controller] == "bulk_edits"
  end

  def university_display(stored_file)
    if stored_file.flags.detect { |f| f == Flag.univ_record }
      "Yes"
    elsif stored_file.flags.detect { |f| f == Flag.may_be_univ_record }
      "Nominated"
    else
      "No"
    end
  end

  # TODO: Update this logic to reflect 3 levels of preservation
  def preserved_display(stored_file)
    if stored_file.flags.detect { |f| f == Flag.preserved }
      "Yes"
    elsif stored_file.flags.detect { |f| f == Flag.selected_preservation }
      "Selected"
    elsif stored_file.flags.detect { |f| f == Flag.nominated_preservation }
      "Nominated"
    else
      "No"
    end
  end

  def preview(stored_file)
    # stored_file is either a StoredFile or a Solr Hit
    # We use to_i() here to force nil values to zero, to create "/0.jpg" instead of "/.jpg"
    if stored_file.is_a?(StoredFile)
      if stored_file.has_thumbnail
        path = thumbnail_stored_file_path(stored_file.id) + ".jpg"
      else
        path = "/mime_type_cat_icons/#{stored_file.mime_type_category_id.to_i}.jpg"
      end 
    else
      if stored_file.stored(:has_thumbnail)
        path = thumbnail_stored_file_path(stored_file.stored(:id)) + ".jpg"
      else
        path = "/mime_type_cat_icons/#{stored_file.stored(:mime_type_category_id).to_i}.jpg"
      end 
    end
    
    return image_tag(path, :class => 'thumbnail', :alt => '')
  end

  def search_by_tags(tag_string)
    # tag_string will come in as "tag1, tag2, tag3"
    output = []
    tag_array = tag_string.split(", ").each do |tag|
     output << link_to(tag, search_path(:"indexed_tag_list[]" => tag))
    end
    output.join(", ").html_safe
  end
end
