class Equipe < ActiveRecord::Base
  belongs_to :rede

  validates :descricao, presence: true
  validates :rede_id, presence: true

  def to_s
    descricao
  end
end
