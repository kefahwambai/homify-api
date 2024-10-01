class RemoveFromHouses < ActiveRecord::Migration[7.0]
  def change
    remove_column :houses, :amenities, :text
    remove_column :houses, :images, :string
    remove_column :houses, :videos, :string
    remove_column :houses, :pdfs, :string
  end
end
