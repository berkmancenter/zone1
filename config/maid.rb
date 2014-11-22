Maid.rules do
  rule 'Old temp zipfiles made for bulk downloading' do
    dir = '/var/apps/zone1/current/downloads/'

    Dir.foreach(dir).each do |path|
      if File.ctime(dir + path) < Time.now
        next if path =~ /^\./
        trash(dir + path)
      end
    end
  end
end
