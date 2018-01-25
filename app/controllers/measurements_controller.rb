class MeasurementsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    sensor = Sensor.where(serial_number: measurement_params[:s_n]).first
    measurement = sensor.measurements.new(value: measurement_params[:v])
    unless measurement.save
      time_now = Time.now.strftime('%Y.%m.%d %H:%M:%S')
      to_logger(request.body.read.to_s +
        "\nErrors: " +  measurement.errors.full_messages.to_s)
    end

    head 200, content_type: "text/html"
  end

  private

  def measurement_params
    args = params.permit(:v, :s_n)
  end

  def to_logger(error_msg)
    time_now = Time.now.strftime('%Y.%m.%d %H:%M:%S')
    error_msg = "\nError time: #{time_now}\nMeasurementsController\n" +
      error_msg + "\n"

    file_name = "#{Rails.root}/log/#{Time.now.strftime('%Y-%m-%d')}.log"
    File.open(file_name, "a+") {|f| f << error_msg}
  end
end
