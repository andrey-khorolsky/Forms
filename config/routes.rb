Rails.application.routes.draw do
  resources :surveys, only: [:index, :show, :create, :destroy]
  resources :groups do
    resources :group_members, only: [:index, :show, :create, :destroy]
  end
end
