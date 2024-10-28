class House < ApplicationRecord
  belongs_to :home_owner
  has_many_attached :images
  has_many_attached :videos
  has_many_attached :pdfs
  
  # serialize :amenities, Array
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
