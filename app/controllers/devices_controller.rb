class DevicesController < ApplicationController
	before_action :set_device, only: %i(show edit update destroy)

	def index
		@devices = Device.all.decorate
	end

	def show; end

	def new
		@device = Device.new
	end

	def create
		@device = Device.new(device_params)
		#@device.save
		
		if possible_to_save? @device
			redirect_to devices_path,
				notice: t('controller.device.create.success')
		else
			# flash[:error] = device_params
			render :new
		end
	end

	def edit; end

	def update
		if @device.update(device_params)
			redirect_to devices_path, notice: t('controller.device.update.success')
		else
			render :edit
		end
	end

	def destroy
		if @device.destroy
			redirect_to sensors_path, notice: t('controller.device.desroy.success')
		else
			redirect_back fallback_location: root_path,
				notice: t('controller.fail', @device.errors.messages[:description].first)
		end
	end

	private
	def set_device
		@device = Device.find(params[:id]).decorate
	end

	def device_params
		params.require(:device).permit(:mi_name, :mi_type_sign,
			analog_params_attributes: [:_destroy, :id, :identifier, :name, :unit, :active,
																 :upper_range_limit, :lower_range_limit],
			discrete_params_attributes: [:_destroy, :id, :identifier, :name, :active],
			arbitrary_params_attributes: [:_destroy, :id, :identifier, :name, :active])
	end

	def possible_to_save? device
		if device_params.keys.length <= 2

			device.errors.add(:params_missing, t('controller.device.params_missing'))
			flash[:error] = t('controller.device.params_missing')
		else
			if has_nil_params? || device.errors.any?
				@device.validate
				device.errors.add(:params_missing, t('controller.device.params_missing'))
				flash[:error] = t('controller.device.params_missing')
			else
				@device.save
			end
		end

		!device.errors.any?
	end

	def has_nil_params? params_for_check = device_params
		params_values = []
		params_for_check.keys.each do |key|
			if params_for_check[key].class == params.class
				params_for_check[key].keys.each do |sub_key|
					params_for_check[key][sub_key].each { |sub_sub_key, val| params_values << val }
				end
			end
		end

		params_values.include?('')
	end
end
