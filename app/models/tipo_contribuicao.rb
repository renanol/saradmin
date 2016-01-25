class TipoContribuicao < ActiveRecord::Base

  has_many :contribuicaos

  validates :descricao, presence: true

end
