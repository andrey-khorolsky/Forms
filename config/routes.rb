Rails.application.routes.draw do
  resources :surveys, only: [:index, :show, :create, :destroy]
  resources :groups
end
