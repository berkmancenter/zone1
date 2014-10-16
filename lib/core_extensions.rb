class Hash
  #pass single or array of keys, which will be removed, returning the remaining hash
  def remove!(*keys)
    keys.each{|key| self.delete(key) }
    self
  end

  #non-destructive version
  def remove(*keys)
    self.dup.remove!(*keys)
  end
  
  def with_defaults(defaults)
    self.merge(defaults) { |key, old, new| old.nil? ? new : old } 
  end

  def with_defaults!(defaults)
    self.merge!(defaults) { |key, old, new| old.nil? ? new : old }
  end
end


class Array
  # from http://snippets.dzone.com/posts/show/4805
  # usage: [1, 2, 3].map_to_hash { |e| {e => e + 100} } # => {1 => 101, 2 => 102, 3 => 103}
  def map_to_hash
    map { |e| yield e }.inject({}) { |carry, e| carry.merge! e }
  end
end



class ActiveRecord::Base  
  attr_accessor :accessible #used to dynamically assign accessible attributes 
  
  private  
  
  #used to dynamically assign accessible attributes
  def mass_assignment_authorizer(role = :default) 
    if accessible == :all  
      self.class.protected_attributes  
    else  
      super(role) + (accessible || [])  
    end  
  end  
end  


require 'sword2ruby'
module Sword2Ruby
  class ::Atom::Collection < ::Atom::Element

    # Monkey-patched post_media! method to get this lib working with Sword 1.3 protocol
    # implementations (X-Packaging header) as well as implementing a few helpful headers
    # that the Sword protocol already supports. -Phunk <bgadoury@endpoint.com>

    #This method creates a new entry in the collection by posting a file to the collection URI.
    #An MD5-digest will be calculated automatically from the file and sent to the server with the request.
    #The method will return a Sword2Ruby::DepositReceipt object, or raise a Sword2Ruby::Exception in the case of an error.
    #===Parameters (passed as a hash collection)
    #:filepath:: a filepath string indicating the file to be posted. The file must be readable by the process.
    #:content_type:: the mime content-type string of the file, e.g. "application/zip" or "text/plain"
    #:packaging:: (optional) the Sword packaging string of the file, e.g. "http://purl.org/net/sword/package/METSDSpaceSIP"
    #:slug:: (optional) the suggested identifier of the new entry
    #:collection_uri:: (optional) the collection URI to post to. If not supplied, this will default to the current collection's URI as specified in the @href attribute.
    #:in_progress:: (optional) boolean value indicating whether the new entry will be completed at a later date
    #:on_behalf_of:: (optional) username on whos behalf the submission is being performed
    #:connection:: (optional) Sword2Ruby::Connection object used to perform the operation. If not supplied, the existing collection's connection will be used.
    #Note that you should call <b><collection>.feed.updated!</b> followed by <b><collection>.feed.update!</b> after making updates to a collection.
    #
    #For more information, see the Sword2 specification: {section 6.3.1. "Creating a Resource with a Binary File Deposit"}[
    # http://sword-app.svn.sourceforge.net/viewvc/sword-app/spec/tags/sword-2.0/SWORDProfile.html?revision=377#protocoloperations_creatingresource_binary].
    def post_media!(params = {})

      Utility.check_argument_class('params', params, Hash)
      defaults = {
        :filepath => nil,
        :content_type => nil,
        :packaging => nil,
        :slug => nil,
        :collection_uri => collection_uri,
        :in_progress => nil,
        :on_behalf_of => nil,
        :connection => @http
      }
      options = defaults.merge(params)

      #Validate parameters
      Utility.check_argument_class(':filepath', options[:filepath], String)
      Utility.check_argument_class(':content_type', options[:content_type], String)
      Utility.check_argument_class(':packaging', options[:packaging], String) if options[:packaging]
      Utility.check_argument_class(':slug', options[:slug], String) if options[:slug]
      Utility.check_argument_class(':collection_uri', options[:collection_uri], String)
      Utility.check_argument_class(':on_behalf_of', options[:on_behalf_of], String) if options[:on_behalf_of]
      Utility.check_argument_class(':connection', options[:connection], Sword2Ruby::Connection)
        
      filename, md5, data = Utility.read_file(options[:filepath])
      
      headers = {"Content-Type" => options[:content_type]}
      headers["Content-MD5"] = md5
      headers["Packaging"] = options[:packaging] if options[:packaging]
      headers["Slug"] = options[:slug] if options[:slug]
      headers["In-Progress"] = options[:in_progress].to_s.downcase if (options[:in_progress] == true || options[:in_progress] == false)
      headers["On-Behalf-Of"] = options[:on_behalf_of] if options[:on_behalf_of]
      
      # Phunk: Wrap filename in quotes to handle filenames with embedded
      # spaces, which some DSpace implementations cannot handle
      headers["Content-Disposition"] = %{attachment; filename="#{filename}"}
      
      # Phunk: Sword 1.3 protocol servers need the "X-Packaging" header, not "Packaging"
      headers["X-Packaging"] = options[:packaging] if options[:packaging]

      # Phunk: From http://www.slideshare.net/swordapp/module-3-how-sword-works slide #31
      headers["X-No-Op"] = 'true' if options[:no_op]

      # Phunk: Get verbose error messages
      headers["X-Verbose"] = 'true'  

      response = options[:connection].post(options[:collection_uri], data, headers)
      
      if response.is_a? Net::HTTPSuccess
        return DepositReceipt.new(response, options[:connection])
      else
        raise Sword2Ruby::Exception.new("Failed to do post_media!(#{options[:collection_uri]}): server returned #{response.code} #{response.message}")
      end
    end
        
  end #class
end #module
