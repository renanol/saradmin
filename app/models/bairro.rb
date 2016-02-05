class Bairro < ActiveRecord::Base
  scope :by_cidade, -> (cidade_id) {where("cidade_id = ?", cidade_id).order("nome")}
  belongs_to :cidade
  has_many :enderecos
end
