class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  attr_accessor :fits_complete

  storage :file

  version :thumb, :if => :fits_complete? do
    process :generate_thumbnail => [100,100]
  end

  def fits_complete?(file)
    Rails.logger.debug "!!!!!!!!!!!fits_complete UPLOADER = #{model.fits_complete?}"
    model.fits_complete?
  end

  def generate_thumbnail(height_limit, width_limit)
    Rails.logger.debug "!!!!!!!inside generate thumbnail"
    resize_to_limit(height_limit, width_limit)
  end

  
  #copied from http://guides.rubyonrails.org/security.html#file-uploads
  def self.sanitize_filename(filename)
      filename.strip.tap do |name|
        # NOTE: File.basename doesn't work right with Windows paths on Unix
        # get only the filename, not the whole path
        name.sub! /\A.*(\\|\/)/, ''
        # Finally, replace all non alphanumeric, underscore
        # or periods with underscore
        name.gsub! /[^\w\.\-]/, '_'
      end
  end

  # Where uploaded files are saved
  def store_dir
    fn = model.file_identifier
    root_dir + "/#{fn[0,1]}/#{fn[1,1]}"
  end

  # Temp dir for uploaded files before they are automagically moved into store_dir
  def cache_dir
    root_dir + "/_cache"
  end

  def root_dir
    "#{Rails.root}/uploads"
  end
  
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    @name ||= "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(16))
  end
end
