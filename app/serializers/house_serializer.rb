class HouseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :video_url, :address, 
             :bathrooms, :bedrooms, :category, :duration, :deposit, 
             :vehicles, :location, :squareFeet, :furnishingStatus, 
             :parkingAvailability, :videos, :pdfs, :amenities, :images

  belongs_to :home_owner

  # include Rails.application.routes.url_helpers  

  def images
    object.images.map { |image| rails_blob_url(image, only_path: true) } if object.images.attached?
  end

  def videos
    object.videos.map { |video| rails_blob_url(video, only_path: true) } if object.videos.attached? 
  end

  def pdfs
    object.pdfs.map { |pdf| rails_blob_url(pdf, only_path: true) } if object.pdfs.attached?    
  end
end
