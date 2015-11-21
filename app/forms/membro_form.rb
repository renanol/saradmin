class MembroForm

  include SimpleFormObject

  attribute :nome
  attribute :data_nascimento
  attribute :cpf
  attribute :rg
  attribute :numero_cadastro, default: Membro.maximum(:id)
  attribute :estado_civil, default: Pessoa.estado_civis[:solteiro]

end