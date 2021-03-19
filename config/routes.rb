Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :reservations, only: [:index, :show, :create, :destroy]
end
