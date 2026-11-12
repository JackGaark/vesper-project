class Venue < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  has_many :packages

  validates :name, :description, :address, :music_genre, presence: true

end
