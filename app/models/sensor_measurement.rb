class SensorMeasurement < ApplicationRecord
	validates :value, :users_sensor_id, presence: true

	belongs_to :users_sensor
end
