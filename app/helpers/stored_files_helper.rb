module StoredFilesHelper
  def editable_field(f, attrs, field, options, type, label="", search_link=false)
      render :partial => "stored_files/editable_field",
             :locals => { :form => f,
               :attrs => attrs,
               :field => field,
               :options => options,
               :type => type, 
               :label => label.presence || field,
               :search_link => search_link }
  end

  def bulk_edit(attr)
    render('bulk_edits/mark_for_edit', attr: attr) if bulk_edit?
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

  def search_by_tags(stored_file, field)
    output = []
    tag_array = stored_file.send(field).split(", ").each do |tag|
     output << link_to(tag, search_path(:"indexed_#{field}[]" => tag))
    end
    output.join(", ").html_safe
  end
end
