class AddRatingToVenues < ActiveRecord::Migration[5.2]
  def change
    add_column :venues, :rating, :float
    add_column :venues, :image_url, :string
    add_column :venues, :review_count, :integer
    add_column :venues, :price, :string
  end
end
