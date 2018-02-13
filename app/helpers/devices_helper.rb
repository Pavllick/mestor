module DevicesHelper
	def tooltip title
		{'data-toggle': 'tooltip', 'data-placement': 'top', 'title': title}
	end

	def close_x
		'text-danger form-group float-right mb-2 mt-2 pt-0 pb-0 pl-0 pr-0'
	end
end
