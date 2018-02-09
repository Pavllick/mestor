Rails.application.routes.draw do
	resources :devices
	resources :analog_params
	resources :discrete_params
	resources :arbitrary_params
	resources :authorized_devices
	resources :instances do
		post '/set_ext_params', to: 'instances#set_ext_params'
	end
	resources :measurements
	post '/measure', to: 'measurements#create'

	resources :users_sensors
	resources :sensor_measurements
	resources :sensors
	resources :sensor_measurements, only: :create
	# post '/sensor_measure', to: 'sensor_measurements#create'
end
