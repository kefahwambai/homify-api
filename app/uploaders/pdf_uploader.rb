class PdfUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader
  storage :file

  # Define the directory where uploaded files will be stored
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a whitelist of extensions allowed to be uploaded
  def extension_whitelist
    %w[pdf]
  end
end
