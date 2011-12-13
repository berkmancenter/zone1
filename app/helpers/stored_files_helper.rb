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
end
