class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    users_root_path
  end
  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    Rails.logger.debug "after_sign_out_path_for: called"
    new_user_session_path
  end
end
