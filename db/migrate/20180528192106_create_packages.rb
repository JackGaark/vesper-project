class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.integer :available_per_night
      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
