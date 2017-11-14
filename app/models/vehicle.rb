# == Schema Information
#
# Table name: vehicles
#
#  id         :integer          not null, primary key
#  identity   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vehicle < ApplicationRecord
  validates :identity, uniqueness: true, presence: true
  has_many :locations
end
