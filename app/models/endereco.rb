class Endereco < ActiveRecord::Base

  belongs_to :igreja
  belongs_to :cidade
  belongs_to :estado
  belongs_to :bairro

  accepts_nested_attributes_for :bairro


end
