class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :location, presence: true
  has_many :reviews, dependent: :destroy

end
