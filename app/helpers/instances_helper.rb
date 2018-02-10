module InstancesHelper
	def load_measurement_data instance, analog_param, seconds
		@data = instance.measurements.last_seconds(analog_param, seconds).pluck(:created_at, :value)
	end

	def chart_options
		second_format = @data.any? ? { second: 'DD.MM' } : { second: ' ' }

    {
    	scales: { 
    		xAxes: [{ 
    			type: "time",
    			time: { 
    				unit: 'second', 
    				# unitStepSize: 4, 
    				tooltipFormat: "DD.MM.YYYY HH:mm:ss", 
    				displayFormats: second_format
    			},
	      	scaleLabel: {
	        	fontSize: 16
      		}, 
      		ticks: {
      			fontSize: 12
      		}
    		}]
    	}
    }
  end
end
