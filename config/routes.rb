Rails.application.routes.draw do
	resources :devices
	resources :analog_params
	resources :discrete_params
	resources :arbitrary_params
	resources :authorized_devices
	resources :instances do
		post '/set_ext_params', to: 'instances#set_ext_params'
	end
	match 'instances/:id/set_ext_params', to: 'instances#show', via: :get

	resources :measurements
	post '/measure', to: 'measurements#create'
end
