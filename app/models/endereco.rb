# == Schema Information
#
# Table name: enderecos
#
#  id               :integer          not null, primary key
#  logradouro       :string
#  numero           :string
#  complemento      :string
#  cep              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  bairro_id        :integer
#  ponto_referencia :string
#

class Endereco < ActiveRecord::Base

  belongs_to :bairro

  attr_accessor :estado_novo
  attr_accessor :pais_id
  attr_accessor :estado_id
  attr_accessor :cidade_id

  def to_s
    "#{self.logradouro}, #{self.numero}, #{self.bairro.nome}"
  end


end
