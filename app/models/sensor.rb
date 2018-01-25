class Sensor < ApplicationRecord
  validates :serial_number, :name, :unit, presence: true
  validates :upper_range_limit, :lower_range_limit, presence: true

  has_many :measurements
end
