class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.references :home_owner, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.decimal :price
      t.string :image

      t.timestamps
    end
  end
end
