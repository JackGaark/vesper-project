class CreateSquadmembers < ActiveRecord::Migration[5.2]
  def change
    create_table :squadmembers do |t|
      t.references :user, foreign_key: true
      t.references :squad, foreign_key: true
      t.references :squadchosenvenue, foreign_key: true
      t.boolean :will_be_present
      t.integer :contribution
      t.integer :swag_points

      t.timestamps
    end
  end
end
