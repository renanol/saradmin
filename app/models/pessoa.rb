# == Schema Information
#
# Table name: pessoas
#
#  id                              :integer          not null, primary key
#  nome                            :string
#  data_nascimento                 :date
#  cpf                             :string
#  rg                              :string
#  estado_civil                    :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  titulo_eleitor_numero_inscricao :string
#  titulo_eleitor_zona             :string
#  titulo_eleitor_secao            :string
#  titulo_eleitor_data_emissao     :date
#

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
