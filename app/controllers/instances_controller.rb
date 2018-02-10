class InstancesController < ApplicationController
  before_action :set_instance, only: %i(show edit update destroy)

  def index
    @instances = Instance.all.decorate
    authorization
  end

  def show; end
  
  def new
    @instance = Instance.new
  end

  def create
    @instance = Instance.new(instance_params)
    if @instance.save
      redirect_to instances_path, notice: t('controller.device.create.success')
    else
      render :new,
        flash: {error: t('controller.fail',
        errors: "<br><hr> #{@instance.errors.full_messages.join("<br>")}")}
    end
  end

  def edit; end

  def update
    if @instance.update(instance_params)
      redirect_to instances_path, notice: t('controller.device.update.success')
    else
      redirect_back fallback_location: instances_path,
                    notice: t('controller.fail', @instance.errors.messages[:description].first)
    end
  end

  def set_ext_params
    @instance = Instance.find(params[:instance_id])
    error_msg = DeviceHandler.post(@instance, ext_params)

    flash[:error] = error_msg if error_msg
    flash[:notice] = t('connection.success') if !@instance.errors.any? && !error_msg
    render :show
  end

  def destroy
    if @instance.destroy
      redirect_to instances_path, notice: t('controller.device.desroy.success')
    else
      redirect_back fallback_location: instances_path,
                    notice: t('controller.fail', @instance.errors.messages[:description].first)
    end
  end

  private
    def instance_params
      params.require(:instance).permit(:serial_number, :note)
    end

    def ext_params
      params.require(:instance).permit(:identifier, :ext_value)
    end

    def set_instance
      @instance = Instance.find(params[:id])
    end

    def authorization
      instances = Instance.all

    	instances.each do |instance|
        device_in_authorization = authorized_device instance.serial_number

    		if device_in_authorization.present?
          instance.device = Device.where(mi_type_sign: device_in_authorization.mi_type_sign).first
		      instance.save
        else
          instance.device = nil
          instance.save
        end
    	end
    end

    def authorized_device serial_number
    	AuthorizedDevice.where(serial_number: serial_number).first
    end
end
