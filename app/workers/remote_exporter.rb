class RemoteExporter
  @queue = :remote_exporter

  def self.perform(repo_name, params)
    Rails.logger.debug "RemoteExporter exporting to repo: #{repo_name} for user: #{params['username']}"
    begin
      repo_class = repo_name.classify.constantize
    rescue NameError => e
      Rails.logger.warn "RemoteExporter Error: Could not convert repo_name param to valid repo module name: #{repo_name}"
      return
    end

    repo_class.export_to_repo(params)
  end

end
