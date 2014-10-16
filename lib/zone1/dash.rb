require "dash/communicator"
require "dash/package"
require "dash/translator"

module Dash

  REPO_NAME = 'dash'

  def self.export_to_repo(params={})
    #TODO: make this handle all keys for newly flattened hash
    if %w( user_id username password collection stored_file_ids).any? {|arg| params[arg].blank?}
      raise ArgumentError, "Missing required param. Got #{params.inspect}"
    end

    stored_files = StoredFile.find(params['stored_file_ids'])
    user = User.find(params['user_id'])

    communicator = Dash::Communicator.new(params['username'], params['password'])

    export_results = []
    stored_files.each do |stored_file|
      begin
        result = {:stored_file => stored_file}
        
        export_package = Dash::Package.new(stored_file)
        receipt = communicator.export_to_repo(export_package, params['collection'])

        if receipt.is_a?(Sword2Ruby::DepositReceipt) && receipt.status_code =~ /^2\d\d/
          result[:success] = true
        end
      rescue ExportToRepo::Unauthorized => e
        result[:message] = "Username or password incorrect."
      rescue Exception => e
        result[:message] = "Error: #{e.message}"
        Rails.logger.warn "#{Dash::REPO_NAME} export error: #{e}"
      ensure
        export_results << result
        export_package.try(:destroy)
      end
    end

    self.process_export_results(user, params, export_results)
    export_results
  end

  def self.process_export_results(user, params, export_results)
    begin
      UserMailer.export_to_repo_confirmation(user, export_results).deliver
    rescue => e
      Rails.logger.warn "#{Dash::REPO_NAME} export_results email error: #{e}"
    end

    info = [
            Dash::REPO_NAME,
            params['username'],
            user.email,
            export_results.map {|r| r[:stored_file].id}.join(',')
           ]
    Rails.logger.info "Export To Repo complete (repo/repo_username/email/stored_file_ids): #{info.join('/')}"
  end

  def self.collections(username, password)
    Dash::Communicator.new(username, password).collections.map {|c| c.title.to_s}
  end

  #TODO: tighten up naming convention and re-test for non-logged-in users
  def self.export_force_refresh(username, password, user_id)
    # Cache it by user_id if possible
    if user_id.present?
      Rails.cache.fetch(self.cache_key(user_id), :force => true) do
        self.collections(username, password)
      end
    else
      self.collections(username, password)
    end
  end

  def self.collections_by_user_id(user_id)
    Rails.cache.read(self.cache_key(user_id))
  end

  def self.cache_key(user_id)
    if user_id.present?
      "#{Dash::REPO_NAME}-export-collections-#{user_id}"
    end
  end

end
