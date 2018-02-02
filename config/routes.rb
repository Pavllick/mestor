Rails.application.routes.draw do
  resources :users_sensors do
  	post '/set_ext_params', to: 'users_sensors#set_ext_params'
  end
  resources :sensor_measurements
  resources :authorized_devices
  resources :sensors
  
  resources :sensor_measurements, only: :create
  post '/sensor_measure', to: 'sensor_measurements#create'
end
