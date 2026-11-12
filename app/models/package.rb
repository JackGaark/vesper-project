class Package < ApplicationRecord
  belongs_to :venue
  has_many :squads

  validates :name, :description, :price, :available_per_night, presence: true
  validates :price, :available_per_night, numericality: { only_integer: true, greater_than: 0 }
  # validates :venue_id, uniqueness: true
end
