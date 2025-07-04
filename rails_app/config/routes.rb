# access http://localhost:3000/rails/info/routes
Rails.application.routes.draw do
  
  # deviseのコントローラをオーバーライド
  devise_for :users,
  controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
    unlocks: "users/unlocks"
  },
  path: 'users/',  # URLが /users/sign_in などになる
  path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out',
    registration: 'sign_up'
  }


  # users
  namespace :users do
    root to: "samples#index"

    get "/samples", controller: "samples", action: :index
  end

  # api
  namespace :api, defaults: { format: :json } do
    resources :samples, only: [:index, :create]
    namespace :v1 do
      # jwt用
      devise_scope :user do
        post 'login', to: 'sessions#create'
        # delete 'logout', to: 'sessions#destroy'
      end
    end
  end

end
