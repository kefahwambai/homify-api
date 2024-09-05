class PurchaseSerializer < ActiveModel::Serializer
  attributes :id
  has_one :home_buyer
  has_one :house
end
