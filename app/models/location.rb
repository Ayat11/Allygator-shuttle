# == Schema Information
#
# Table name: locations
#
#  id           :integer          not null, primary key
#  lat          :decimal(10, 6)
#  lng          :decimal(10, 6)
#  retrieved_at :datetime
#  vehicle_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Location < ApplicationRecord
  validates :lat, :lng, :retrieved_at, :vehicle_id, presence: true
  belongs_to :vehicle
end
