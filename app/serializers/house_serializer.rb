class HouseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :address, :bathrooms, :bedrooms, 
             :category, :duration, :location, :squareFeet, :furnishingStatus, 
             :parkingAvailability, :deposit, :vehicles, :video_url, :amenities, 
             :image_urls, :video_urls, :pdf_urls

  # has_one :home_owner

  def image_urls
    if object.image.attached?
      object.image.map { |image| Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) }
    else
      []
    end
  end

  def video_urls
    if object.video.attached?
      object.video.map { |video| Rails.application.routes.url_helpers.rails_blob_url(video, only_path: true) }
    else
      []
    end
  end

  def pdf_urls
    if object.pdf.attached?
      object.pdf.map { |pdf| Rails.application.routes.url_helpers.rails_blob_url(pdf, only_path: true) }
    else
      []
    end
  end
end
