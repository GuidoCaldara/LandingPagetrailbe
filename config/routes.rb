Rails.application.routes.draw do
  root "pages#home"
  devise_for :users, :controllers => {registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks'
}
  get "/privacy", to: "pages#privacy", as: "privacy"
  get "users/edit_profile", to: "users#edit_profile", as: "edit_user_profile"
  get "/runs_finder", to: "runs#runs_finder", as: "runs_finder"
  patch "users/update_profile", to: "users#update_profile", as: "update_user_profile"
  resources :runs, only: [:index]


  resources :users do
    resources :runs, only: [:index]
  end

  resources :runs, except: [:index] do
    resources :partecipants, only: [:create, :destroy]
    resources :messages, only: [:create, :destroy, :edit, :update]
  end
  resources :messages, only: [:edit]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
