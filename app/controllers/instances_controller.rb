class InstancesController < ApplicationController
  before_action :set_instance, only: [:show, :edit, :update, :destroy]

  def index
    @instances = Instance.all
    authorization
  end

  def show; end
  
  def new
    @instance = Instance.new
  end

  def create
    @instance = Instance.new(instance_params)
    if @instance.save
      redirect_to instances_path, notice: t('controller.instance.create.success')
    else
      render :new,
        flash: {error: t('controller.fail',
        errors: "<br><hr> #{@instance.errors.full_messages.join("<br>")}")}
    end
  end

  def edit; end

  def update
    if @instance.update(instance_params)
      redirect_to instances_path, notice: t('controller.instance.update.success')
    else
      redirect_back fallback_location: instances_path,
                    notice: t('controller.fail', @instance.errors.messages[:description].first)
    end
  end

  def set_ext_params
    data = params[:data]
    error_msg = DeviceHandler.post({'data': data})
    if !error_msg
      redirect_back fallback_location: instances_path, notice: t('connection.success')
    else
      redirect_back fallback_location: instances_path, flash: {error: error_msg}
    end
  end

  def destroy
    if @instance.destroy
      redirect_to instances_path, notice: t('controller.instance.desroy.success')
    else
      redirect_back fallback_location: instances_path,
                    notice: t('controller.fail', @instance.errors.messages[:description].first)
    end
  end

  private
    def instance_params
      params.require(:instance).permit(:serial_number, :note)
    end

    def set_instance
      @instance = Instance.find(params[:id])
    end

    def authorization
      users_sensors = Instance.all

    	instances.each do |instance|
        device_in_authorization = authorized_device instance.serial_number

    		if device_in_authorization.present?
          instance.sensor = Device.where(mi_type_sign: device_in_authorization.mi_type_sign).first
		      instance.save
        else
          instance.sensor = nil
          instance.save
        end
    	end
    end

    def authorized_device serial_number
    	AuthorizedDevice.where(serial_number: serial_number).first
    end
end
