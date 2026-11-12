class ChangeVenuePriceToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :venues, :pricing, :integer, using: 'id::integer'
  end
end
