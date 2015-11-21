class SubEquipe < ActiveRecord::Base
  belongs_to :equipe
  def to_s
    descricao
  end
end
