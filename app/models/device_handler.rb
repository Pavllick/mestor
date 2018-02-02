class DeviceHandler < ApplicationRecord
	require 'net/http'
	require 'net/https'
	require 'uri'

  def self.post data
		# http = Net::HTTP.new(uri.host, uri.port)
		# resp = http.post(uri, data)

		# http = Net::HTTP.new(uri.host, uri.port)
		# request = Net::HTTP::Post.new(uri.request_uri)
		# request.body = data
		# response = http.request(request)

		uri = URI("http://localhost:8000")

		attempts = 0
		error_msg = nil
		error_count = 20

		begin
			attempts += 1

			req = Net::HTTP::Post.new(uri)
			res = Net::HTTP.start(uri.host, uri.port, {opentimeout: 1}) do |http|
				sleep 0.1
				req.set_form_data data

				http.request(req)
			end
    rescue Net::OpenTimeout, Net::ReadTimeout, Errno::ECONNREFUSED
    	error_msg = I18n.t('connection.fail.timeout')
		rescue
			error_msg = I18n.t('connection.fail.config') if attempts == error_count
			retry if attempts < error_count
		end

		error_msg
	end
end