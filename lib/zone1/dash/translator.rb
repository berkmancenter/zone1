module Dash
  
  class Translator
    # mets builder needs ApplicationHelper
#    include ApplicationHelper

    def self.build_metadata(stored_file)
      raise ArgumentError, "can't build metadata for nil stored_file" if stored_file.nil?
      #ActionController::Base.send(:include, ApplicationHelper)
      ActionController::Base.new.render_to_string('stored_files/export_to_repo/_package.mets', :locals => {:stored_file => stored_file})
    end

    def self.translate_DEPRECATED(params = {})
      # Creates a new Atom::Entry with standard atom fields populated by the
      # (possibly translated) params hash names/values. Does not support dublin_core_extentions.

      # keys that don't map yet
      unknown_keys = %w( rights source content [contributors] links categories(collections?) )

      # key is StoredFile attribute name, value is Atom::Entry name
      renamed_keys = {
        'id' => 'id',
        'title' => 'title',
        'updated_at' => 'updated',
        'original_date' => 'published',
        'description' => 'summary'
      }

      # keys that need to be translated, "cleaned up" etc
      translated_keys = {}

      entry_params = {}
      params.each do |k,v|
        next unless v.present? && renamed_keys.has_key?(k)
        # create a new entry where the key is the renamed key, and the value is the original value
        entry_params[renamed_keys[k]] = v
      end

      entry = Atom::Entry.new(entry_params)
      if params['author'].present?
        params['author'].split(/,\s*/).each do |author|
          entry.authors<< Atom::Author.new(:name => author.strip)
        end
      end

      entry
    end
  end
end
