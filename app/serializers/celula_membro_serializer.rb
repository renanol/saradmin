class CelulaMembroSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :membro
  belongs_to :celula
end
