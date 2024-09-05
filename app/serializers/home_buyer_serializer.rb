class HomeBuyerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :purchases
end
