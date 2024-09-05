class HomeOwnerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :houses
end

