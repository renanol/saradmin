class GrupoPermissao < ActiveRecord::Base

  belongs_to :grupo
  belongs_to :permissao

  enum valor: [:nenhuma, :visualizar, :alterar, :sim, :nao]

end
