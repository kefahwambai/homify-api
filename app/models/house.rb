class House < ApplicationRecord
  belongs_to :home_owner
  has_one_attached :images
  has_one_attached :videos
  has_one_attached :pdfs
  # mount_uploader :video, VideoUploader
  # mount_uploader :pdf, PdfUploader
  serialize :amenities, Array
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
