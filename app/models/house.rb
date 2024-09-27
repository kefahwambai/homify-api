class House < ApplicationRecord
  belongs_to :home_owner
  has_one_attached :image
  has_one_attached :video
  has_one_attached :pdf

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
