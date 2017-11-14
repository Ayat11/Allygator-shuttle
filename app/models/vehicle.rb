class Vehicle < ApplicationRecord
  validates :identity, uniqueness: true, presence: true
  has_many :locations
end
