class HomeOwner < ApplicationRecord
  has_secure_password
  has_many :houses, dependent: :destroy
  validates :email, presence: true, uniqueness: true
end
