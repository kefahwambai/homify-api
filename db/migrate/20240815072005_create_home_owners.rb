class CreateHomeOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :home_owners do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
