class AddDepositToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :deposit, :integer
  end
end
