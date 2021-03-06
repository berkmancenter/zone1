class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  version :thumbnail, :if => :wants_thumbnail? do
    # TODO: Could you define the filename method just for :thumbnail here a la https://groups.google.com/forum/#!topic/carrierwave/mtTFkoT82pg ?
    process :resize_to_limit => [200, 200]
    #process :convert =>['jpg'] ?
  end

  def wants_thumbnail?(uploader)
    # Note: that uploader param is automagically supplied by CarrierWave
    # We 'rescue true' to err on the side of letting CarrierWave try to create
    # thumbnails even if we couldn't figure out the mime_type on our own.
    # TODO: find a slicker way to broaden the scope of what is considered thumbnail-able
    !!model.wants_thumbnail && !!(model.mime_type.mime_type.to_s =~ /^image|pdf$/i rescue true)
  end

  def has_thumbnail?
    # Note: Only works for default thumbnail generated by 'version :thumbnail'. 
    # If we had to create our own .jpg thumbnail, it won't be accessible
    # TODO: Can we make this detect an app-generated .jpg thumbnail as well?
    File.exists? model.file.thumbnail.file.path rescue false
  end

  def move_to_store
    true
  end
  
  def move_to_cache
    true
  end
  
  def store_dir
    # Where uploaded files are saved
    fn = model.file_identifier
    root_dir + "/#{fn[0,1]}/#{fn[1,1]}"
  end

  def cache_dir
    # Temp dir for uploaded files before they are automagically moved into store_dir.
    # Avoid using a small partition, as failed uploads may sit in this directory
    # until removed via cronjob, etc.
    root_dir + "/_cache"
  end

  def root_dir
    "#{Rails.root}/uploads"
  end
  
  def filename
    # Generate the new filename for uploaded files. Avoid using model.id or
    # version_name here, see uploader/store.rb for details.

    # Note: This logic looks a little convoluted because it needs to ensure
    # this file and its versions get the same base filename even when called
    # in two separate processes (i.e. @name will be nil in the second process.)
    @name ||= model.file_identifier if model.file_identifier
    ext = file.try(:extension).present? ? ".#{file.extension.downcase}" : ''
    @name ||= secure_token + ext if original_filename.present?
  end

  protected
  def secure_token
    #get or generate a random string
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(16))
  end
end
