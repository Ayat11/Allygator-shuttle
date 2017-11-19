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

FactoryBot.define do
  factory :location do
    lat  FFaker::Geolocation.lat    
    lng  FFaker::Geolocation.lng    
    retrieved_at  FFaker::Time.datetime
    after(:build) do |location|
      location.vehicle = FactoryBot.create(:vehicle)
    end
  end
end
