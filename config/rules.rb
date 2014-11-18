Maid.rules do
  # **NOTE:** It's recommended you just use this as a template; if you run these rules on your machine without knowing
  # what they do, you might run into unwanted results!

  # NOTE: Currently, only Mac OS X supports `downloaded_from`.
  rule 'Old temp zipfiles made for bulk downloading' do
    Dir.foreach(Capistrano::release_path).each do |path|
      if File.ctime(path) < Time.now
        next if path =~ /^\./
        trash(path)
      end
    end
  end
end
