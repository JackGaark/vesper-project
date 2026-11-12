class AddColumnToVenues < ActiveRecord::Migration[5.2]
  def change
    add_column :venues, :pricing, :integer
  end
end
