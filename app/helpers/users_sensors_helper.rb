module UsersSensorsHelper
	def load_measurement_data users_sensor, quantity
		users_sensor.sensor_measurements.last(quantity).pluck(:created_at, :value)
	end
end
