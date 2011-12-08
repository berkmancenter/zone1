class ImageUploader < CarrierWave::Uploader::Base
  #include CarrierWave::RMagick

  storage :file

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def root_dir
    "#{Rails.root}/public/uploaded_images/"
  end

  #version :thumb do
  #  process :resize_to_fill => [200,200]
  #end
end
