class AddBioToHomeOwners < ActiveRecord::Migration[7.0]
  def change
    add_column :home_owners, :bio, :text
  end
end
