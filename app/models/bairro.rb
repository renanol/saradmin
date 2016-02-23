# == Schema Information
#
# Table name: bairros
#
#  id         :integer          not null, primary key
#  nome       :string
#  cidade_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bairro < ActiveRecord::Base
  scope :by_cidade, -> (cidade_id) {where("cidade_id = ?", cidade_id).order("nome")}
  belongs_to :cidade
  has_many :enderecos

  validates :nome, uniqueness: {scope: :cidade_id}
end
