# == Schema Information
#
# Table name: vehicles
#
#  id         :integer          not null, primary key
#  identity   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it "is valid with all attributes" do
    expect(FactoryBot.build(:vehicle)).to be_valid
  end

  it "is not valid without lat and lng" do
    vehicle = FactoryBot.build(:vehicle, identity: nil)
    expect(vehicle).to_not be_valid
  end
end
