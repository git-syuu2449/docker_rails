module Api
  class Api::SamplesController < ApplicationController

    include Pundit

      before_action :authenticate_user!  # ログイン確認　クッキー認証＋JWT
      after_action :verify_authorized, except: [:index, :create]

    # jwtを使わない
    def index
      # 認可
      authorize [:api, :samples]
      # authorize current_user

      # 認証方式をログに出力する debug
      strategy = request.env['warden'].winning_strategy.class.name
      logger.debug "認証方式： " <<  strategy
      logger.debug "request.headers.Authorization: " << request&.headers.inspect

      # サンプルでユーザー一覧を返却
      users = User.all
      render json: users, status: :ok

      rescue Pundit::NotAuthorizedError
        logger.error "権限エラー"
        render json: { error: '権限がありません' }, status: :forbidden
      rescue => e
        # 検知できないエラーは個別に対応するかは要検討
        logger.error e
        logger.error e.message
        render json: { error: e.message }, status: :internal_server_error
    end

    def create
    end

  end

end
