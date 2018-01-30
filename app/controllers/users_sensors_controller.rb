class UsersSensorsController < ApplicationController
  before_action :set_users_sensor, only: [:show, :edit, :update, :destroy]

  def index
    @users_sensors = UsersSensor.all
    authorization
  end

  def show; end

  def new
    @users_sensor = UsersSensor.new
  end

  def create
    @users_sensor = UsersSensor.new(users_sensor_params)
    if @users_sensor.save
      redirect_to users_sensors_path,
                    notice: t('controller.users_sensor.create.success')
    else
      redirect_back fallback_location: users_sensors_path,
        flash: {error: t('controller.fail',
        errors: "<br><hr> #{@users_sensor.errors.full_messages.join("<br>")}")}
    end
  end

  def edit; end

  def update
    if @users_sensor.update(users_sensor_params)
      redirect_to users_sensors_path,
                    notice: t('controller.users_sensor.update.success')
    else
      redirect_back fallback_location: root_path,
                    notice: t('controller.fail',
                            @users_sensor.errors.messages[:description].first)
    end
  end

  def destroy
    if @users_sensor.destroy
      redirect_to users_sensors_path,
                    notice: t('controller.users_sensor.desroy.success')
    else
      redirect_back fallback_location: root_path,
                    notice: t('controller.fail',
                            @users_sensor.errors.messages[:description].first)
    end
  end

  private
    def users_sensor_params
      params.require(:users_sensor).permit(:serial_number, :note)
    end

    def set_users_sensor
      @users_sensor = UsersSensor.find(params[:id])
    end

    def authorization
      users_sensors = UsersSensor.all

    	users_sensors.each do |users_sensor|
        device_in_authorization = authorized_device users_sensor.serial_number

    		if device_in_authorization.present?
          users_sensor.sensor = Sensor.where(mi_type_sign: device_in_authorization.mi_type_sign).first
		      users_sensor.save
        else
          users_sensor.sensor = nil
          users_sensor.save
        end
    	end
    end

    def authorized_device serial_number
    	AuthorizedDevice.where(serial_number: serial_number).first
    end
end
