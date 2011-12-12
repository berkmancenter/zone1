namespace :zone_one do
  desc "Delete zip and manifest files in RAILS_ROOT/tmp older than 1 hour"
  task :remove_download_sets => :environment do
    base_path = Rails.root + "tmp" #Pathname class
    targeted_extensions = %w(.zip .txt)

    base_path.each_entry do |file|
      #file also Pathname class

      if !file.directory? && 
          targeted_extensions.include?(file.extname) && 
          file.to_s.include?("download_") && 
          File.mtime(file) < 1.hour.ago

        begin
          FileUtils.rm(base_path + file)
        rescue 
          puts "Unable to delete file: #{base_path + file}"
        end
      end
    end
  end
end
