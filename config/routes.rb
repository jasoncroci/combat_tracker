Rails.application.routes.draw do
  devise_for :users, only: :sessions
  resources :encounters do
    resources :enemies
    post 'combats', to: "combats#create", as: :combats
  end
  resources :characters
  resources :combats, only: [:show,:update]
  # Lastest battle
  get 'combat', to: "combats#current_combat", as: :current_combat
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'waiting_room#index'
end
