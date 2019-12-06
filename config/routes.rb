Rails.application.routes.draw do
  devise_for :accounts

  devise_for :admins
  # devise_for :admins
  # devise_scope :admin do
  #   post    '/admins/sign_up'   => 'devise/registrations#create',     as: :admin_registration
  # end

  resources :unlocks, controller: 'rails_jwt_auth/unlocks', only: %i[update]
  resources :invitations, controller: 'rails_jwt_auth/invitations', only: [:create, :update]
  resources :passwords, controller: 'rails_jwt_auth/passwords', only: [:create, :update]
  resources :confirmations, controller: 'rails_jwt_auth/confirmations', only: [:create, :update]
  # resources :registration, controller: 'rails_jwt_auth/registrations', only: [:create, :update, :destroy]
  # resources :session, controller: 'rails_jwt_auth/sessions', only: [:create, :destroy]

  # resources :session, controller: 'sessions', only: [:create, :destroy]

  post '/api/session', to: 'sessions#create'
  delete '/api/session/:id', to: 'sessions#destroy'

  post '/api/registration', to: 'registrations#create'
  put '/api/registration', to: 'registrations#update'
  delete '/api/registration/:id', to: 'registrations#destroy'

  post '/inactivity', to: "api_inactivity#receive"
  post '/start_horodator', to: 'api_horodator_schedule#start_horodator'
  put '/end_horodator', to: 'api_horodator_schedule#end_horodator'

  get '/current_user', to: 'api_horodator_schedule#test_user'

  get '/test_date', to: 'window_activity#test_date'
  post '/active_window', to: 'window_activity#receive'

  post '/last_visited_url', to: 'visited_url#last_url'
  post '/start_visit_url', to: 'visited_url#start_visit'
  put '/blur_visited_url', to: 'visited_url#blur'
  put '/focus_visited_url', to: 'visited_url#focus'
  put '/end_visit_url', to: 'visited_url#end_visit'


  get '/admin/dashboard', to: 'user#index', as: 'dashboard_admin'
  get '/admin/manage_users', to: 'user#manage_users', as: 'manage_users'
  get '/admin/create_user', to: 'user#create', as: 'create_user'
  delete '/admin/destroy_user/:id', to: 'user#destroy', as: 'destroy_user'


  get '/user_state/:id', to: 'user_state#index', as: 'user_state'
  get '/user_state/:id/windows', to: 'user_state#all_windows_activities'
  get '/user_state/:id/inactivities', to: 'user_state#all_inactivities'
  get '/user_state/:id/urls_visited', to: 'user_state#all_url_visited'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
