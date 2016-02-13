# == Schema Information
#
# Table name: igreja_enderecos
#
#  id          :integer          not null, primary key
#  igreja_id   :integer
#  endereco_id :integer
#  descricao   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class IgrejaEndereco < ActiveRecord::Base

  belongs_to :igreja
  belongs_to :endereco

  accepts_nested_attributes_for :endereco

end
