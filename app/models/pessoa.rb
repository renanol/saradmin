class Pessoa < ActiveRecord::Base

  has_one :membro

  has_many :pessoa_enderecos
  has_many :enderecos, through: :pessoa_enderecos

  has_many :pessoa_contatos
  has_many :contatos, through: :pessoa_contatos

  accepts_nested_attributes_for :pessoa_enderecos
  accepts_nested_attributes_for :contatos

  validates :nome, presence: true

  enum estado_civil: [:solteiro, :casado, :divorciado, :viuvo, :outros]

  #def estado_civil_dsc
  #  if self.solteiro?
  #    'Solteiro'
  #  else
  #    'Casado'
  #  end
  #end

  def to_s
    nome
  end


end
