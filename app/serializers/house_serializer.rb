class HouseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :video_url, :address, 
             :bathrooms, :bedrooms, :category, :duration, :deposit, 
             :vehicles, :location, :squareFeet, :furnishingStatus, 
             :parkingAvailability, :videos, :pdfs, :amenities, :images

  belongs_to :home_owner

  # include Rails.application.routes.url_helpers  

  def images
    Rails.application.routes.url_helpers.rails_blob_url(object.images, only_path: true) if object.images.attached?
  end

  def videos
    Rails.application.routes.url_helpers.rails_blob_url(object.videos, only_path: true) if object.videos.attached?
  end

  def pdfs
    Rails.application.routes.url_helpers.rails_blob_url(object.pdfs, only_path: true) if object.pdfs.attached?  
  end
end
