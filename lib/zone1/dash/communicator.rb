require 'sword2ruby'

module Dash

  class Communicator

    def initialize(username, password)
      @username = username
      @password = password
    end
    
    def export_to_repo(export_package, collection_name)
      # It looks like the DASH server only supports the post_media! call in sword2ruby
      collection = get_collection(collection_name)
      collection.post_media!(:filepath => export_package.path,
                             :content_type => 'application/zip',
                             :packaging => 'http://purl.org/net/sword-types/METSDSpaceSIP',
                             :on_behalf_of => nil,  #useful? not sure yet.
                             :no_op => false,
                             )
    end

    def get_collection(collection_name)
      collections.detect {|col| col.title.to_s == collection_name}
    end

    def collections
      Array.wrap(self.service.collections)
    end

    def service
      connection = Sword2Ruby::Connection.new(Sword2Ruby::User.new(@username, @password))
      begin
        return Atom::Service.new(Dash::Communicator.service_document_uri, connection)
      rescue Atom::Unauthorized => e
        raise ExportToRepo::Unauthorized.new(e.message)
      end
    end

    def self.service_document_uri
      config_file = File.join(Rails.root, 'config', 'export_to_repo', Dash::REPO_NAME + '.yml')
      @config ||= YAML::load( File.open(config_file) )
      @config[Rails.env]['service_document_url']
    end

  end
  
end
