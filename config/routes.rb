Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}, defaults: {format: :json}
  # get "/auth/:provider/callback", to: "sessions#create"

  resources :surveys, only: [:index, :show, :create, :destroy] do
    resources :answers, only: [:index, :show, :create, :destroy]
  end
  resources :groups do
    resources :group_members, only: [:index, :show, :create, :destroy]
  end
end
