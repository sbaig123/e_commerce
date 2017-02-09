Rails.application.routes.draw do

	root 'products#index'
	get 'sign_up', to: 'users#new'
	get 'sign_in', to: 'sessions#new'
	get 'sign_out', to: 'sessions#destroy'
	post 'sessions', to: 'sessions#create'
	resources :users
  resources :products
	resource :cart, only: [:show]
	resources :order_items, only: [:create, :update, :destroy]

end
