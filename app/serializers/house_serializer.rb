class HouseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :video_url, :address, 
             :bathrooms, :bedrooms, :category, :duration, :deposit, 
             :vehicles, :location, :squareFeet, :furnishingStatus, 
             :parkingAvailability, :video, :pdf, :amenities,  image: []

  has_one :home_owner
  

  def image
    Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end

  def video
    object.video.url if object.video.present?   
  end

  def pdf
    object.pdf.url if object.pdf.present?      
  end
end
