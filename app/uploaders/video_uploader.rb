class VideoUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader
  # e.g., :file for local storage or :fog for cloud storage (like AWS S3)
  storage :file

  # Define the directory where uploaded files will be stored
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a whitelist of extensions allowed to be uploaded
  def extension_whitelist
    %w[mp4 avi mov wmv]
  end
end
