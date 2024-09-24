class AddImagesToHomeOwners < ActiveRecord::Migration[7.0]
  def change
    add_column :home_owners, :image, :string
  end
end
