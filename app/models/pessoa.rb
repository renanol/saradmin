class Pessoa < ActiveRecord::Base

  has_one :membro

  enum estado_civil: [:solteiro, :casado]

  attr_accessor :nome, :data_nascimento, :cpf, :rg, :numero_cadastro, :estado_civil

end
