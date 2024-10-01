class HouseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :video_url, :address, 
             :bathrooms, :bedrooms, :category, :duration, :deposit, 
             :vehicles, :location, :squareFeet, :furnishingStatus, 
             :parkingAvailability, :video, :pdf, :amenities, :image

  has_one :home_owner

  include Rails.application.routes.url_helpers  

  def image
    if object.images.attached?
      object.images.map { |image| rails_blob_url(image, only_path: true) }
    else
      []
    end
  end

  def video
    if object.video.attached?
      rails_blob_url(object.video, only_path: true)
    else
      nil
    end  
  end

  def pdf
    if object.pdf.attached?
      rails_blob_url(object.pdf, only_path: true)
    else
      nil
    end     
  end
end
