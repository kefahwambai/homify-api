class ImageUploader < CarrierWave::Uploader::Base
  # Specify the storage location, e.g., file storage or cloud storage
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
