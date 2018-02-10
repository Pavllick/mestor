class MeasurementsController < ApplicationController
	skip_before_action :verify_authenticity_token

  def create
    # logger.debug '*'*40
    # logger.debug params
    # logger.debug '*'*40
    instance = Instance.where(serial_number: measurement_params[:serial_number]).first
    if instance.present?
      checked_idents = instance.device.analog_params.map(&method(:check_ident))
      if !checked_idents.include?(false)
        measurement = instance.measurements.new(measurement_params.except(:serial_number))
        unless measurement.save
          to_logger(request.body.read.to_s +
            "\nErrors: " +  measurement.errors.full_messages.to_s)
        end
      end
    end
    
    head 200, content_type: "text/html"
  end

  private

  def check_ident an_param
    an_param.identifier == measurement_params[:identifier]
  end

  def measurement_params
    params.permit(:serial_number, :identifier, :value)
  end

  def to_logger(error_msg)
    time_now = Time.now.strftime('%Y.%m.%d %H:%M:%S')
    error_msg = "\nError time: #{time_now}\nMeasurementsController\n" +
      error_msg + "\n"

    file_name = "#{Rails.root}/log/#{Time.now.strftime('%Y-%m-%d')}.log"
    File.open(file_name, "a+") {|f| f << error_msg}
  end
end
