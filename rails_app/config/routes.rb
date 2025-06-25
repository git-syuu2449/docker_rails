# access http://localhost:3000/rails/info/routes
Rails.application.routes.draw do
  devise_for :users

  # root
  root to: "sample#index"

  get "/sample", controller: "sample", action: :index

  # admin
  namespace :admin do
  end

  # api
  namespace :api do
    get "sample/index"
    get "sample/create"
    namespace :v1 do
      # resources :users, only: [:index, :create]
    end
  end

end
