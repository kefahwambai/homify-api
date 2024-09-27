class AddVideoToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :video, :string
    add_column :houses, :video_url, :string
  end
end
