class ChangeAmenitiesToTextInHouses < ActiveRecord::Migration[6.1]
  def change
    change_column :houses, :amenities, :text
  end
end
