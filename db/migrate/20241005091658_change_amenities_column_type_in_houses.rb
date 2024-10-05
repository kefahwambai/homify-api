class ChangeAmenitiesColumnTypeInHouses < ActiveRecord::Migration[6.0]
  def change
    change_column :houses, :amenities, :text, array: true, default: [], using: 'amenities::text[]'
  end
end

