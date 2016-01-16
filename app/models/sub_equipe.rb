class SubEquipe < ActiveRecord::Base

  belongs_to :responsavel, class_name: "Membro", foreign_key: "responsavel_id"

  belongs_to :equipe
  def to_s
    descricao
  end
end
