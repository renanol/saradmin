class Igreja < ActiveRecord::Base
  has_many :enderecos
  accepts_nested_attributes_for :enderecos
  validates :descricao, presence: true

  def to_s
    descricao
  end
end
