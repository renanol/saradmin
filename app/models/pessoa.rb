class Pessoa < ActiveRecord::Base

  has_one :membro

  has_many :pessoa_enderecos
  has_many :enderecos, through: :pessoa_enderecos

  has_many :pessoa_contatos
  has_many :contatos, through: :pessoa_contatos

  enum estado_civil: [:solteiro, :casado]

  attr_accessor :nome, :data_nascimento, :cpf, :rg, :numero_cadastro, :estado_civil

end
