class CreateSquads < ActiveRecord::Migration[5.2]
  def change
    create_table :squads do |t|
      t.datetime :night_out
      t.references :user, foreign_key: true
      t.references :package
      t.boolean :confirmed

      t.timestamps
    end
  end
end
