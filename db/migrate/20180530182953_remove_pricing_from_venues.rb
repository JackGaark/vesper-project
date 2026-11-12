class RemovePricingFromVenues < ActiveRecord::Migration[5.2]
  def change
    remove_column :venues, :price
    remove_column :venues, :image_url
    change_column :venues, :pricing, :string
  end
end
