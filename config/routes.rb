Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}

  root :to => "home#index"
  resources :rooms do
    resources :messages, only: [:create, :destroy]
  end

  get "/search", to: "search#index"

  resources :profiles, only: [:show]
end
