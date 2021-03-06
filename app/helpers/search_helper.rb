module SearchHelper

  def toggle_field_box(column_class, label=column_class.titleize)
    output = check_box_tag("toggle_#{column_class}_fields", 1, true, :class => "toggle_column", "data-column-class" => column_class)
    output << label_tag("toggle_#{column_class}_fields", label)
    output
  end

  def sortable(column, title=nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort_column => column, :sort_direction => direction, :page => nil), {:class => css_class}
  end

  def university_flag_display(flag_ids)
    return nil unless flag_ids
    flags = Flag.all.inject({}) { |h, f| h[f.name] = f.id; h }

    if flag_ids.include?(flags["UNIVERSITY_RECORD"])
      content_tag 'span', 'U', :class => 'highlighted'
    elsif flag_ids.include?(flags["MAY_BE_UNIVERSITY_RECORD"])
      content_tag 'span', 'U'
    end
  end

  def preserved_flag_display(flag_ids)
    return nil unless flag_ids
    flags = Flag.all.inject({}) { |h, f| h[f.name] = f.id; h }

    if flag_ids.include?(flags["PRESERVED"])
      content_tag 'span', 'P', :class => 'highlighted'
    elsif flag_ids.include?(flags["SELECTED_FOR_PRESERVATION"])
      content_tag 'span', 'P', :class => 'selected'
    elsif flag_ids.include?(flags["NOMINATED_FOR_PRESERVATION"])
      content_tag 'span', 'P'
    end
  end
  
  def per_page
    session[:per_page] = params[:per_page] || session[:per_page] || "10"
  end
end
