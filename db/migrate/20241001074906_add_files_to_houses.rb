class AddFilesToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :images, :string
    add_column :houses, :videos, :string
    add_column :houses, :pdfs, :string
  end
end
