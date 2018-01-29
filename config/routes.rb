Rails.application.routes.draw do
  resources :users_sensors
  resources :sensor_measurements
  resources :authorized_devices
  resources :sensors
  
  resources :sensor_measurements, only: :create
  post '/sensor_measure', to: 'sensor_measurements#create'
end
