class Squadchosenvenue < ApplicationRecord
  belongs_to :squad
  belongs_to :venue

  # validates :venue, presence: true
  # validates :venue, uniqueness: true
end
