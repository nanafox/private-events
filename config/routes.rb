Rails.application.routes.draw do
  devise_for :users,
             path: "auth",
             path_names: {
               sign_in: "login", sign_out: "logout",
               password: "secret", confirmation: "verification",
               unlock: "unblock", sign_up: "register"
             },
             controllers: {
               registrations: "users/registrations", sessions: "users/sessions"
             }

  get "events/creator/me", to: "events#current_user_events", as: :current_user_events
  get "events/creator/:username", to: "events#user_events", as: :user_events
  resources :events, only: %i[index new create show edit update destroy] do
    resources :attendances, only: %i[create destroy]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "events#index"
end
