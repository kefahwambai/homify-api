class RemoveImageVideoPdfFromHouses < ActiveRecord::Migration[7.0]
  def change
    remove_column :houses, :image, :string
    remove_column :houses, :video, :string
    remove_column :houses, :pdf, :string
  end
end
