module Api
  class SamplesPolicy < ApplicationPolicy
    def index?
      # 全権限OK
      user.admin? || user.general? || user.editor?
      # user.admin?  # 管理者のみ表示可能
      # user.general? # 一般のみ表示可能
      # user.editor? # 編集者のみ表示可能
    end

    def create?
      current_user.admin?
    end

    class Scope < ApplicationPolicy::Scope

    end
  end
end