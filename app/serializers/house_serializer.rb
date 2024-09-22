class HouseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :image, :address, 
             :bathrooms, :bedrooms, :category, :duration, :deposit, 
             :vehicles, :location, :squareFeet, :furnishingStatus, 
             :parkingAvailability

  has_one :home_owner

  def image
    # Return the URL of the attached image if it exists
    Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end

  def formatted_price
    # Format the price with commas for thousands and two decimal places
    sprintf('%.2f', object.price)
  end
end
