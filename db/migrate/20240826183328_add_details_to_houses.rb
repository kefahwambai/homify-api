class AddDetailsToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :address, :string
    add_column :houses, :bathrooms, :integer
    add_column :houses, :bedrooms, :integer
    add_column :houses, :category, :string
    add_column :houses, :duration, :string
    add_column :houses, :location, :string
    add_column :houses, :square, :string
  end
end
