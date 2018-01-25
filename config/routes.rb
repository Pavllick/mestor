Rails.application.routes.draw do
  resources :sensors
  
  resources :measurements, only: :create
  post '/measure', to: 'measurements#create'
end
