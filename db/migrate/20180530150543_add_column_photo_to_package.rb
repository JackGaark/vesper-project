class AddColumnPhotoToPackage < ActiveRecord::Migration[5.2]
  def change
    add_column :packages, :photo, :string
  end
end
