class AddVehiclesToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :vehicles, :integer
  end
end
