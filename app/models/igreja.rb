class Igreja < ActiveRecord::Base
  has_many :enderecos
  accepts_nested_attributes_for :enderecos, :allow_destroy => true
  validates :descricao, presence: true

  def to_s
    descricao
  end
end
