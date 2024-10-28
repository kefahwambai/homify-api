class HomeOwnerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :bio, :image
  has_many :houses

  def image
    if object.image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: false)
    else
      nil 
    end
  end
end
