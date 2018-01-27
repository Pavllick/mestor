class UsersSensor < ApplicationRecord
	validates :serial_number, :authorized, :sensor_id, presence: true

  has_many :sensor_measurements
  belongs_to :sensor
end
