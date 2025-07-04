module Api
    module v1
        class SessionsController < Devise::SessionsController
            skip_before_action :verify_authenticity_token
            respond_to :json

            def create
                self.resource = warden.authenticate!(auth_options)
                sign_in(resource_name, resource)
                render json: { token: current_token }, status: :ok
                rescue
                render json: { error: 'メールアドレスまたはパスワードが正しくありません' }, status: :unauthorized
            end

            private

            def current_token
            request.env['warden-jwt_auth.token']
            end
        end
    end
end
