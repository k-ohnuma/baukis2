Rails.application.routes.draw do
  namespace :staff, path: "" do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resource :session, only: [:create, :destroy]
    resource :account, expect: [:new, :create, :destroy]
    # post "session" => "sessions#create", as: :session
    # delete "session" => "sessions#destroy" 
  end

  namespace :admin do
    root "top#index"
    get "login" => "sessions#new", as: :login
    # post "session" => "sessions#create", as: :session
    # delete "session" => "sessions#destroy"
    resource :session, only: [:create, :destroy]
    resources :staff_members
  end

  namespace :customer do
    root "top#index"
  end
end
