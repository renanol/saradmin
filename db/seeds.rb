# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
grupo_list = [
  [ 'root', Grupo.status[:ativo] ],
  [ 'Administrador', Grupo.status[:ativo] ],
  [ 'Usuário', Grupo.status[:ativo] ]
]

grupo_list.each do |name, status|
  Grupo.create( descricao: name, status: status )
end

permissao_list = [
  [ 'permissaoUsuario', Permissao.modulos[:configuracao], Permissao.tipos[:acesso], 'Nível de acesso ao menu de usuários' ],
  [ 'permissaoGrupo', Permissao.modulos[:configuracao], Permissao.tipos[:acesso], 'Nível de acesso ao menu de grupo de usuário' ]
]

permissao_list.each do |aliass, modulo, tipo, descricao|
  Permissao.create( alias: aliass, modulo: modulo, tipo: tipo, descricao: descricao )
end

Grupo.all.each do |grupo|
  Permissao.all.each do |perm|
    if perm.acesso?
      valor = GrupoPermissao.valores[:nenhuma]
      if grupo.id == 1 || grupo.id == 2
        valor = GrupoPermissao.valores[:alterar]
      end
    else
      valor = GrupoPermissao.valores[:nao]
      if grupo.id == 1 || grupo.id == 2
        valor = GrupoPermissao.valores[:sim]
      end
    end
    GrupoPermissao.create( grupo_id: grupo.id, permissao_id: perm.id, valor: valor )
  end
end