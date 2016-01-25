class Equipe < ActiveRecord::Base

  belongs_to :rede

  belongs_to :responsavel, class_name: "Membro", foreign_key: "responsavel_id"

  validates :descricao, presence: true
  validates :rede_id, presence: true
  validates :responsavel_id, presence: true

  def to_s
    descricao
  end
end
