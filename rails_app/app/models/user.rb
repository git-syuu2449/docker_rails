class User < ApplicationRecord

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         # jwt
         :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  
  # 権限
  enum role: { general: 0, editor: 1, admin: 2 }

  def has_role?(target)
    role == target.to_s
  end

  # 有効なユーザー
  scope :active, -> { where(deleted_at: nil) }

end
