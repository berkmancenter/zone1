namespace :zone_one do
  desc "Delete zip and manifest files in RAILS_ROOT/tmp older than 1 hour"
  task :remove_download_sets => :environment do
    Dir.glob("#{Rails.root}/downloads/download*") do |file|
      if File.mtime(file) < 1.hour.ago
        begin
          File.delete(file)
        rescue 
          puts "Unable to delete file: #{base_path + file}"
        end
      end
    end
  end

  desc "Clear all low level caches"
  task :clear_cache do   
    # Rails.cache.clear is not working, so system call made.
    # ::Rails.cache.clear
    system("rm -rf #{Rails.root}/tmp/cache/*") 
  end
end
