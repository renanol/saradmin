class Igreja < ActiveRecord::Base
  has_many :enderecos
  has_many :igreja_contatos

  accepts_nested_attributes_for :enderecos, :allow_destroy => true
  accepts_nested_attributes_for :igreja_contatos, :allow_destroy => true

  validates :descricao, presence: true

  def to_s
    descricao
  end
end
