class RedePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    if @user.tem_permissao ['usuarioPodeAcessarTodosOsNiveisDaIgreja']
      return true
    else
      membro = Membro.find_by_user_id(@user.id)

      unless membro.nil?
        redes = Rede.where(responsavel_id: membro.id)

        if redes.length > 0
          return true
        end

      end

      return false
    end
  end
end
