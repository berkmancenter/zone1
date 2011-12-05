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

  def university_flag_display(search_hit)
    flag_labels = Flag.label_map.invert
    if search_hit.stored(:flag_ids)
      if search_hit.stored(:flag_ids).include?(flag_labels["University Record"].to_i)
        content_tag 'span', 'U', :class => 'highlighted'
      elsif search_hit.stored(:flag_ids).include?(flag_labels["May be University Record"].to_i)
        content_tag 'span', 'U'
      end
    end
  end

  # TODO: Update this logic to reflect 3 levels of preservation
  def preserved_flag_display(search_hit)
    flag_labels = Flag.label_map.invert
    if search_hit.stored(:flag_ids)
      if search_hit.stored(:flag_ids).include?(flag_labels["Preserved"].to_i)
        content_tag 'span', 'P', :class => 'highlighted'
      elsif search_hit.stored(:flag_ids).include?(flag_labels["Nominated for Preservation"].to_i)
        content_tag 'span', 'P'
      end
    end
  end
end
