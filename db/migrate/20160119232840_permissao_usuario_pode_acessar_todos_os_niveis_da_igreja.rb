class PermissaoUsuarioPodeAcessarTodosOsNiveisDaIgreja < ActiveRecord::Migration
  def change

    Permissao.create(
        modulo: Permissao.modulos[:configuracao],
        tipo: Permissao.tipos[:sim_nao],
        alias: 'usuarioPodeAcessarTodosOsNiveisDaIgreja',
        descricao: 'Usuário pode acessar todos os níveis da igreja'
    )

    p = Permissao.find_by_alias('usuarioPodeAcessarTodosOsNiveisDaIgreja')

    Grupo.all.each do |g|

      if(g.id == 1 || g.id == 2)

        GrupoPermissao.create(
            permissao_id: p.id,
            grupo_id: g.id,
            valor: GrupoPermissao.valores[:sim]
        )

      else

        GrupoPermissao.create(
            permissao_id: p.id,
            grupo_id: g.id,
            valor: GrupoPermissao.valores[:nao]
        )

      end

    end

  end
end
