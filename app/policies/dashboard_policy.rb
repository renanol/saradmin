class DashboardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    @user.admin? && @user.permissao('permissaoUsuario').alterar?
  end
end
