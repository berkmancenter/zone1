class MimeTypeCategoryIconUploader < CarrierWave::Uploader::Base
  #include CarrierWave::RMagick

  storage :file

  #process :resize_to_fit => [200,200]
  #process :convert => 'png'

  def extension_white_list
    #%w(jpg jpeg gif png)
    %w(png)
  end

  def filename
    @name = "#{self.model.id}.png"
  end

  def store_dir
    # Where uploaded files are saved
    root_dir
  end

  def root_dir
    "#{Rails.root}/public/mime_type_cat_icons"
  end

end
