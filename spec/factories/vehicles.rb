# == Schema Information
#
# Table name: vehicles
#
#  id         :integer          not null, primary key
#  identity   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :vehicle do
    identity "MyString"
  end
end
