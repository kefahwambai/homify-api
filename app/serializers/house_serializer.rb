class HouseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :formatted_price, :image, :address, :bathrooms, :bedrooms, :category, :duration, :location, :square
  has_one :home_owner

  def formatted_price
    # Format the price with commas for thousands and two decimal places
    sprintf('%.2f', object.price)
  end

end
