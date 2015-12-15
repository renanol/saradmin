class Pessoa < ActiveRecord::Base

  has_one :membro

  has_many :pessoa_enderecos
  has_many :enderecos, through: :pessoa_enderecos

  has_many :pessoa_contatos
  has_many :contatos, through: :pessoa_contatos

  accepts_nested_attributes_for :membro
  accepts_nested_attributes_for :enderecos
  accepts_nested_attributes_for :contatos

  enum estado_civil: [:solteiro, :casado]

  # estado_civil setter
  def estado_civil=(estado_civil)
    if not estado_civil.kind_of? Fixnum
      estado_civil = estado_civil.to_i
    end
    super
  end

  def estado_civil_dsc
    if self.solteiro?
      'Solteiro'
    else
      'Casado'
    end
  end

  def to_s
    nome
  end


end
