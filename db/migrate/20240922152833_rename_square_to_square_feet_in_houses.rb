class RenameSquareToSquareFeetInHouses < ActiveRecord::Migration[6.1]
  def change
    rename_column :houses, :square, :squareFeet
  end
end
