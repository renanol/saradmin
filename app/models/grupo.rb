class Grupo < ActiveRecord::Base

  has_many :user
  has_many :grupo_permissaos

  accepts_nested_attributes_for :grupo_permissaos

  enum status: [:ativo, :cancelado]

end
