class Permissao < ActiveRecord::Base

  has_many :grupo_permissaos

  enum tipos: [:acesso, :sim_nao]
  enum modulos: [:configuracao]

end
