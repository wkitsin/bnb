Rails.application.routes.draw do
  get 'listings/new'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :edit, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
      # resources :listings
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/profile" => "users#profile"

  resources :listings do 
    resources :reservations 
  end 

  get "/search" => "listings#search"
  post "/listings/:id/verify" => "listings#verify", as: 'verify'
end
