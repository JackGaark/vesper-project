class CreateSquadchosenvenues < ActiveRecord::Migration[5.2]
  def change
    create_table :squadchosenvenues do |t|
      t.references :squad, foreign_key: true
      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
