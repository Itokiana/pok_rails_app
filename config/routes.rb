Rails.application.routes.draw do
  root to: 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'settings/index'

  devise_for :admins, controllers: {
      sessions: 'admins/sessions',
      passwords: 'admins/passwords',
      registrations: 'admins/registrations'
  }

  # devise_for :admins
  # devise_for :admins
  # devise_scope :admin do
  #   post    '/admins/sign_up'   => 'devise/registrations#create',     as: :admin_registration
  # end

  resources :unlocks, controller: 'rails_jwt_auth/unlocks', only: %i[update]
  resources :invitations, controller: 'rails_jwt_auth/invitations', only: [:create, :update]
  # resources :passwords, controller: 'rails_jwt_auth/passwords', only: [:create, :update]
  resources :confirmations, controller: 'rails_jwt_auth/confirmations', only: [:create, :update]
  # resources :registration, controller: 'rails_jwt_auth/registrations', only: [:create, :update, :destroy]
  # resources :session, controller: 'rails_jwt_auth/sessions', only: [:create, :destroy]

  # resources :session, controller: 'sessions', only: [:create, :destroy]

  put '/api/passwords/:id', to: "passwords#update"
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


  get '/dashboard/dashboard', to: 'user#index', as: 'dashboard_admin'
  get '/dashboard/manage_users', to: 'user#manage_users', as: 'manage_users'
  get '/dashboard/create_user', to: 'user#create', as: 'create_user'
  delete '/dashboard/destroy_user/:id', to: 'user#destroy', as: 'destroy_user'
  get '/api/admin/total_schedule', to: 'user#total_schedule'
  get '/api/admin/top_apps', to: 'user#top_five_app'
  get '/api/admin/top_urls', to: 'user#top_five_url'
  get '/api/admin/user_active', to: 'user#user_active'


  get '/user_state/:id', to: 'user_state#index', as: 'user_state'
  get '/user_state/profil/:id', to: 'user_state#profil', as: 'user_profil'
  post '/user_state/:id/user_details', to: 'user_state#create_user_details', as: 'create_user_details'
  post '/user_state/:id/add_user_team', to: 'user_state#add_user_team', as: 'add_user_team'
  get '/user_state/:id/windows', to: 'user_state#all_windows_activities'
  get '/user_state/:id/inactivities', to: 'user_state#all_inactivities'
  get '/user_state/:id/urls_visited', to: 'user_state#all_url_visited'


  get "/teams", to: "team#all"
  get "/teams/:id/show", to: "team#show", as: 'show_team'
  post "/teams/create", to: "team#create", as: 'create_team'
  put "/teams/:id/update", to: "team#update"
  delete "/teams/:id", to: "team#destroy", as: 'delete_team'

  get "/time_check_first", to: "time_check#all"
  post "/time_check/create", to: "time_check#create", as: 'create_time_check'
  put "/time_check/:id/update", to: "time_check#update"
  delete "/time_check/:id", to: "time_check#destroy"

  get "/dashboard/settings", to: 'settings#index', as: 'settings'
  get "/dashboard/settings/time_check", to: 'settings#timecheck'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
