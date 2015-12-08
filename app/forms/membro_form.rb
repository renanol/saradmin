class MembroForm

  include SimpleFormObject

  attribute :nome
  attribute :data_nascimento
  attribute :cpf
  attribute :rg
  attribute :numero_cadastro
  attribute :estado_civil, Integer, default: Pessoa.estado_civis[:solteiro]
  attribute :endereco

  attribute :tipo_contato
  attribute :desc_contato
  attribute :email
  attribute :telefone

  attribute :igreja_id

end