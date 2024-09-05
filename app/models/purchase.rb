class Purchase < ApplicationRecord
  belongs_to :home_buyer
  belongs_to :house
end
