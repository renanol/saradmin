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