class Squad < ApplicationRecord
  belongs_to :user
  belongs_to :package, optional: true
  has_many :squadmembers
  has_many :squadchosenvenues
  has_many :venues, through: :squadchosenvenues

  validates :user_id, presence: true
  # validates :user_id, uniqueness: true

end
