class UsersSensor < ApplicationRecord
	validates :serial_number, presence: true

  has_many :sensor_measurements
  belongs_to :sensor, optional: true
end
