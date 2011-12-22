require 'zip/zip'
require 'zip/zipfilesystem'

class DownloadSet

  include ActionView::Helpers::NumberHelper

  attr_reader :path, :file

  def initialize(stored_files)
    download_root = "#{Rails.root}/downloads"
    Dir.mkdir(download_root) unless File.directory?(download_root)
    @path = "#{download_root}/download_#{SecureRandom.hex(8)}.zip"
    manifest_path = @path + "_manifest.txt"

    @file = Zip::ZipFile.open(@path, Zip::ZipFile::CREATE) do |download_set|
      File.open(manifest_path, 'w') do |manifest|
        manifest_header(manifest)
        stored_files.each_with_index do |stored_file, index|
          update_set(stored_file.file_url, stored_file.original_filename, index, download_set)
          update_manifest(stored_file, index, manifest)
        end
        manifest_footer(manifest)
      end

      update_set(manifest_path, "manifest.txt", -1, download_set)
    end
  end

  private

  def separator(file)
    file.puts "============================================="
  end

  def manifest_footer(file)
    separator(file)
    file.puts "End of manifest"
  end

  def manifest_header(file)
    file.puts "Download manifest"
    separator(file)
  end

  def update_set(filepath, filename, index, set)
    name = "#{index+1}_" + filename
    set.add(name, filepath)
  end

  def update_manifest(file, index, manifest)
    manifest.puts "File #{index+1}: #{file.original_filename}"
    manifest.puts tab + "MD5 checksum: #{file.md5}"
    manifest.puts tab + "Contributor: #{file.contributor_name}"
    manifest.puts tab + "File size: #{number_to_human_size(file.file_size)}"
    if file.batch_id
      manifest.puts tab + "Batch: #{file.batch_id}"
    end
    manifest.puts tab + "Ingest date: #{file.created_at.strftime("%m-%d-%Y")}"
    manifest.puts
  end

  def tab
    "    "
  end
end
