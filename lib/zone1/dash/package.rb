module Dash

  class Package
    require 'zip/zip'

    attr_reader :path

    def initialize(stored_file)
      metadata = Dash::Translator.build_metadata(stored_file)
      metadata_file = create_metadata_file(metadata)
      raise Exception, "create_metadata_file returned nil" if metadata_file.nil?

      @path = create_zipfile(stored_file, metadata_file)
    end

    def destroy
      File.unlink(@path) rescue nil
    end

    private

    def create_metadata_file(metadata)
      filename = "/tmp/mets.xml.#{SecureRandom.hex(4)}"
      File.open(filename, "w") {|file| file.write metadata}
      filename
    end

    def create_zipfile(stored_file, metadata_file)
      export_dir = File.join(Rails.root, 'tmp', 'exports', Dash::REPO_NAME)
      zipfile_dir = FileUtils.makedirs(export_dir).first
      zipfile_path = File.join(zipfile_dir, "#{SecureRandom.hex(4)}.zip")
      
      Zip::ZipFile.open(zipfile_path, Zip::ZipFile::CREATE) do |zipfile|
        zipfile.add("mets.xml", metadata_file)
        zipfile.add(stored_file.original_filename || 'no-filename', stored_file.file_url)
      end
      
      File.unlink(metadata_file)
      zipfile_path
    end

  end

end
