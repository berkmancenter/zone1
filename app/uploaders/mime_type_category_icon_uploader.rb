class MimeTypeCategoryIconUploader < CarrierWave::Uploader::Base

  storage :file

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    "/mime_type_cat_icons/default_mime_type_cat_icon.png"
  end

  def store_dir
    # Where uploaded files are saved
    root_dir
  end

  def root_dir
    "#{Rails.root}/public/mime_type_cat_icons"
  end

end
