class InstanceDecorator < ApplicationDecorator
  delegate_all

  def border_danger?
		!instance.device ? 'border-danger bg-transparent' : 'border-success bg-transparent'
	end

	def header_danger?
		!instance.device ? 'text-white bg-danger' : 'text-white bg-success'
	end
end
