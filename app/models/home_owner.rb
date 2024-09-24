class HomeOwner < ApplicationRecord
  has_secure_password
  has_one_attached :image
  has_many :houses, dependent: :destroy
  validates :email, presence: true, uniqueness: true
end
