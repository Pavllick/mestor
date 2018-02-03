class SensorMeasurementsController < ApplicationController
	 skip_before_action :verify_authenticity_token

  def create
    # logger.debug '*'*40
    # logger.debug params
    # logger.debug '*'*40
    users_sensor = UsersSensor.where(serial_number: sensor_measurement_params[:s_n]).first
    if(users_sensor.present?)
      sensor_measurement = users_sensor.sensor_measurements.new(value: sensor_measurement_params[:v])
      unless sensor_measurement.save
        to_logger(request.body.read.to_s +
          "\nErrors: " +  sensor_measurement.errors.full_messages.to_s)
      end
    end
    
    head 200, content_type: "text/html"
  end

  private

  def sensor_measurement_params
    params.permit(:v, :s_n)
  end

  def to_logger(error_msg)
    time_now = Time.now.strftime('%Y.%m.%d %H:%M:%S')
    error_msg = "\nError time: #{time_now}\nMeasurementsController\n" +
      error_msg + "\n"

    file_name = "#{Rails.root}/log/#{Time.now.strftime('%Y-%m-%d')}.log"
    File.open(file_name, "a+") {|f| f << error_msg}
  end
end
