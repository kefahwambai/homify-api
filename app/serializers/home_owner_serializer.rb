class HomeOwnerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :bio, :image
  has_many :houses

  def image
    Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end
end

