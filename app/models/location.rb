class Location < ApplicationRecord
  validates :lat, :lng, :retrieved_at, :vehicle_id, presence: true
  belongs_to :vehicle
end
