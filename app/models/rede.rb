class Rede < ActiveRecord::Base

  belongs_to :responsavel, class_name: "Membro", foreign_key: "responsavel_id"


  def to_s
    descricao
  end
end
