class AddAmenitiesToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :amenities, :string
  end
end
