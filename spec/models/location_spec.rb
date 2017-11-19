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

require 'rails_helper'

RSpec.describe Location, type: :model do
  it "is valid with all attributes" do
    expect(FactoryBot.build(:location)).to be_valid
  end

  it "is not valid without lat and lng" do
    location = FactoryBot.build(:location, lat: nil, lng: nil)
    expect(location).to_not be_valid
  end
end
