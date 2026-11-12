class AddCapacityToVenue < ActiveRecord::Migration[5.2]
  def change
    add_column :venues, :capacity, :integer
  end
end
