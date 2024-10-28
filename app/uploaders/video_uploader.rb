class VideoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def public_id
    "houses/#{model.id}/#{file.original_filename}"
  end
  
  version :thumbnail do
    process resize_to_fit: [100, 100]
  end
end
