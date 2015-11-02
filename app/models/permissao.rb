class Permissao < ActiveRecord::Base

  has_many :grupo_permissaos
  has_many :grupos, through: :grupo_permissaos

  enum tipo: [:acesso, :sim_nao]
  enum modulo: [:configuracao]

end
