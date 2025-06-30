# access http://localhost:3000/rails/info/routes
Rails.application.routes.draw do
  # devise_for :admins
  devise_for :users

  # users
  namespace :users do
    root to: "samples#index"

    get "/samples", controller: "samples", action: :index
  end

  # deviseのログアウトがgetになる問題
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # admins 現状roleでわける。必要になったら分離
  # namespace :admins do
  #   root to: "samples#index"
  #   get "/samples", controller: "samples", action: :index
  # end

  # api
  namespace :api do
    get "samples/index"
    get "samples/create"
    namespace :v1 do
      # resources :users, only: [:index, :create]
    end
  end

end
