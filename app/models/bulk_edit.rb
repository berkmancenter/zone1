class BulkEdit

  # This determines the intersection of all editable fields in 
  # all selected files in bulk edit. The bulk editable fields
  # are the only fields shown as editable on the bulk edit display.
  def self.bulk_editable_attributes(stored_files, user)
    attrs = stored_files.first.attr_accessible_for({}, user)
    stored_files.each do |stored_file|
      attrs = attrs & stored_file.attr_accessible_for({}, user)
    end
    attrs
  end

  def self.matching_attributes_from(stored_files)
    attributes_to_match = StoredFile.new.attribute_names + ["tag_list", "collection_list"]

    matching = {}
    stored_files.each do |stored_file|
      attributes_to_match.each do |attribute|
        value = stored_file.send(attribute)

        if matching[attribute].nil?
          matching[attribute] = value
        elsif matching[attribute] != value
          #on any mis-match
          matching[attribute] = ""
        end
      end
    end
    
    matching
  end

  def self.matching_flags_from(stored_files)
    flags = stored_files.first.flags

    stored_files.each do |stored_file|
      flags = flags & stored_file.flags
    end

    flags    
  end

  def self.matching_groups_from(stored_files)
    groups = stored_files.first.groups

    stored_files.each do |stored_file|
      groups = groups & stored_file.groups
    end

    groups
  end
end
