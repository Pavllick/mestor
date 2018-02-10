module UsersSensorsHelper
	# def load_measurement_data users_sensor, quantity
	# 	data = users_sensor.sensor_measurements.last(quantity).pluck(:created_at, :value)
	# 	# data.map{ |i, d| [i.strftime('%k:%M:%S %d-%m-%Y'), d] }
	# end

	# def chart_options users_sensor
	# 	data = load_measurement_data(users_sensor, 2).count > 0
	# 	second_format = data ? { second: 'DD.MM' } : { second: ' ' }

 #    {
 #    	scales: { 
 #    		xAxes: [{ 
 #    			type: "time",
 #    			time: { 
 #    				unit: 'second', 
 #    				# unitStepSize: 4, 
 #    				tooltipFormat: "DD.MM.YYYY HH:mm:ss", 
 #    				displayFormats: second_format
 #    			},
	#       	scaleLabel: {
	#         	fontSize: 16
 #      		}, 
 #      		ticks: {
 #      			fontSize: 12
 #      		}
 #    		}]
 #    	}
 #    }
 #  end
end
