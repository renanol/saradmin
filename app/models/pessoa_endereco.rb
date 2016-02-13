# == Schema Information
#
# Table name: pessoa_enderecos
#
#  id          :integer          not null, primary key
#  pessoa_id   :integer
#  endereco_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  descricao   :string
#

class PessoaEndereco < ActiveRecord::Base

  belongs_to :pessoa
  belongs_to :endereco

  accepts_nested_attributes_for :endereco

end
