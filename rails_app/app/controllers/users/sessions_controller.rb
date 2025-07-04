# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # respond_to :json

  def destroy
      super do
          Rails.logger.debug "SessionsController delete: called"
          return redirect_to new_user_session_path, status: :see_other
      end
  end

  private

  # def respond_with(resource, _opts = {})
  #   render json: { message: 'ログインしました', user: resource }, status: :ok
  # end

  # def respond_to_on_destroy
  #   head :no_content
  # end
end
