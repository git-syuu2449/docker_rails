class User < ApplicationRecord

  # デバイス　DB認証可能
  devise :database_authenticatable,
      # 登録
      :registerable,
      # 回復
      :recoverable,
      # パスワード忘れ
      :rememberable,
      # email確認
      # :confirmable,
      # バリデーション
      :validatable,
      # JWT によるログイン／認証を使う
      :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  
  # 権限
  enum :role, { general: 0, editor: 1, admin: 2 }, prefix: true

  def has_role?(target)
    role == target.to_s
  end

  # 有効なユーザー
  scope :active, -> { where(deleted_at: nil) }

end
