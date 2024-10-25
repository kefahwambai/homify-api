class House < ApplicationRecord
  belongs_to :home_owner
  # has_many_attached :image
  # has_many_attached :video
  # has_many_attached :pdf
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader
  mount_uploader :pdf, PdfUploader

  
  # serialize :amenities, Array
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
