class SensorsController < ApplicationController
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]

  def index
    @sensors = Sensor.all
  end

  def show; end

  def new
    @sensor = Sensor.new
  end

  def create
    @sensor = Sensor.new(sensor_params)
    if @sensor.save
      redirect_to sensors_path,
                    notice: t('controller.sensor.create.success')
    else
      redirect_back fallback_location: sensors_path,
        flash: {error: t('controller.fail',
        errors: "<br><hr> #{@sensor.errors.full_messages.join("<br>")}")}
    end
  end

  def edit; end

  def update
    if @sensor.update(sensor_params)
      redirect_to sensors_path,
                    notice: t('controller.sensor.update.success')
    else
      redirect_back fallback_location: root_path,
                    notice: t('controller.fail',
                            @sensor.errors.messages[:description].first)
    end
  end

  def destroy
    if @sensor.desroy
      redirect_to sensors_path,
                    notice: t('controller.sensor.desroy.success')
    else
      redirect_back fallback_location: root_path,
                    notice: t('controller.fail',
                            @sensor.errors.messages[:description].first)
    end
  end

  private
    def sensor_params
      params.require(:sensor).permit(:mi_name, :mi_type_sign, :unit,
                                     :upper_range_limit, :lower_range_limit)
    end

    def set_sensor
      @sensor = Sensor.find(params[:id])
    end
end
