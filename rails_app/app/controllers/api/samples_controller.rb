module Api
  class Api::SamplesController < ApplicationController

    include Pundit

      before_action :authenticate_user!  # devise-jwt認証
      after_action :verify_authorized, except: [:some_public_action]

    def index
      # 認可
      authorize User

      users = User.all
      render json: users, status: :ok

      rescue Pundit::NotAuthorizedError
        render json: { error: '権限がありません' }, status: :forbidden
      rescue => e
        render json: { error: e.message }, status: :internal_server_error
    end

    def create
    end

  end
end
