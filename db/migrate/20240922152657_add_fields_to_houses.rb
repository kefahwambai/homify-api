class AddFieldsToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :furnishingStatus, :string
    add_column :houses, :parkingAvailability, :string
  end
end
