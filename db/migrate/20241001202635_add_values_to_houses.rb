class AddValuesToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :amenities, :string, array: true, default: []
  end
end
