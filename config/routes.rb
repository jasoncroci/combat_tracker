Rails.application.routes.draw do
  resources :encounters do
    resources :enemies
    post 'combats', to: "combats#create", as: :combats
  end
  resources :characters
  resources :combats, only: [:show,:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
