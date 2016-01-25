class Rede < ActiveRecord::Base

  belongs_to :responsavel, class_name: "Membro", foreign_key: "responsavel_id"
  belongs_to :igreja

  validates :descricao, presence:true
  validates :responsavel_id, presence:true


  def to_s
    descricao
  end
end
