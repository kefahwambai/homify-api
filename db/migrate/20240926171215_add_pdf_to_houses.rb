class AddPdfToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :pdf, :string
  end
end
