class MimeTypeCategoryIconUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  process :resize_to_fill => [200,200]
  process :convert => 'jpg'

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    @name ||= "#{model.id}.#{model.icon.file.extension}" if original_filename.present?
  end

  def default_url
    "/mime_type_cat_icons/default_mime_type_cat_icon.jpg"
  end

  def store_dir
    # Where uploaded files are saved
    root_dir
  end

  def root_dir
    "#{Rails.root}/public/mime_type_cat_icons"
  end

end
