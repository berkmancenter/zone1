module StoredFilesHelper
  def bulk_edit(attr)
    check_box_tag("attr_for_bulk_edit[]", attr) if bulk_edit?
  end

  def bulk_edit?
    params[:controller] == "bulk_edits"
  end
end
