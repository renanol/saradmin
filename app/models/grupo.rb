class Grupo < ActiveRecord::Base
  after_initialize :set_default_attr, :if => :new_record?

  has_many :users
  has_many :grupo_permissaos
  has_many :permissaos, through: :grupo_permissaos

  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :grupo_permissaos

  enum status: [:ativo, :cancelado]


  def set_default_attr
    self.status ||= :ativo
  end

end
