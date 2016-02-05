class Endereco < ActiveRecord::Base

  belongs_to :bairro

  validates :bairro_id, presence: true
  validates :logradouro, presence: true

  attr_accessor :estado_novo
  attr_accessor :pais_id
  attr_accessor :estado_id
  attr_accessor :cidade_id


end