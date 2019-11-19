Rails.application.routes.draw do
  resources :unlocks, controller: 'rails_jwt_auth/unlocks', only: %i[update]
  resources :invitations, controller: 'rails_jwt_auth/invitations', only: [:create, :update]
  resources :passwords, controller: 'rails_jwt_auth/passwords', only: [:create, :update]
  resources :confirmations, controller: 'rails_jwt_auth/confirmations', only: [:create, :update]
  resources :registration, controller: 'rails_jwt_auth/registrations', only: [:create, :update, :destroy]
  resources :session, controller: 'rails_jwt_auth/sessions', only: [:create, :destroy]

  post '/inactivity', to: "api_inactivity#receive"
  post '/start_horodator', to: 'api_horodator_schedule#start_horodator'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
