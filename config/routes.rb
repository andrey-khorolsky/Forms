Rails.application.routes.draw do
  resources :surveys, only: [:index, :show, :create, :destroy] do
    resources :answers, only: [:index, :show, :create, :destroy]

    resource :answer_statistics, only: :show
    resource :answer_spreadsheet, only: :show
  end
  resources :groups do
    resources :group_members, only: [:index, :show, :create, :destroy]
  end
end
