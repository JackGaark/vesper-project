class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.float :longitude
      t.float :latitude
      t.string :address
      t.string :music_genre
      t.string :instagram_handle

      t.timestamps
    end
  end
end
