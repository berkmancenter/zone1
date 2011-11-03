require 'zip/zip'
require 'zip/zipfilesystem'

class DownloadSet

  attr_reader :path, :file

  def initialize(selected_stored_files)
    @path = "#{Rails.root}/tmp/download_#{ActiveSupport::SecureRandom.hex(8)}.zip"    
    @file = Zip::ZipFile.open(@path, Zip::ZipFile::CREATE) do |download_set|
      selected_stored_files.each_with_index do |stored_file, index|
        count = (index+1).to_s
        filename = "#{count}_" + stored_file.original_filename
        filepath = stored_file.file.to_s
        download_set.add(filename, filepath)
      end
    end
  end
end
