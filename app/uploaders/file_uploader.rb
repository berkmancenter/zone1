class FileUploader < CarrierWave::Uploader::Base

  storage :file

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
