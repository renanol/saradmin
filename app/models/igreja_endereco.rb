class IgrejaEndereco < ActiveRecord::Base

  belongs_to :igreja
  belongs_to :endereco

  accepts_nested_attributes_for :endereco

end
