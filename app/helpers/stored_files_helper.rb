module StoredFilesHelper
  def editable_field(f, attrs, field, options, type)
      render :partial => "stored_files/editable_field",
             :locals => { :form => f,
               :attrs => attrs,
               :field => field,
               :options => options,
               :type => type }
  end

  def bulk_edit(attr)
    check_box_tag("attr_for_bulk_edit[]", attr) if bulk_edit?
  end

  def bulk_edit?
    params[:controller] == "bulk_edits"
  end
end
