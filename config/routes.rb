Rails.application.routes.draw do
  concern :permissionable do
    resources :permissions
  end

  devise_for :users,
    path: "",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "signup"
    },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }

  resources :surveys, only: [:index, :show, :create, :destroy], concerns: :permissionable do
    resources :answers, only: [:index, :show, :create, :destroy]

    resource :answer_statistics, only: :show
    resource :answer_spreadsheet, only: :show
  end

  resources :groups, concerns: :permissionable do
    resources :group_members, only: [:index, :show, :create, :destroy]
  end
end
