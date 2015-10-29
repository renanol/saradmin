class Grupo < ActiveRecord::Base

  has_many :user
  has_many :grupo_permissaos

  enum status: [:ativo, :cancelado]

end
