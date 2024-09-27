class AddCurrencyToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :currency, :string
  end
end
