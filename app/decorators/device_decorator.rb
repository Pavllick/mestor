class DeviceDecorator < ApplicationDecorator
  delegate_all

	def border_danger?
		params_present = device.analog_params.any? ||
										 device.discrete_params.any? ||
										 device.arbitrary_params.any?

		!params_present ? 'border-danger bg-transparent' : 'border-success bg-transparent'
	end

	def header_danger?
		params_present = device.analog_params.any? ||
										 device.discrete_params.any? ||
										 device.arbitrary_params.any?

		!params_present ? 'text-white bg-danger' : 'text-white bg-success'
	end

	def title
		"#{t("device.mi_name.#{device.mi_name}")} / #{device.mi_type_sign}"
	end

	def params_length device_param
		": #{device_param.length.to_s}"
	end
end
