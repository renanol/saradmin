class Cidade < ActiveRecord::Base

  scope :by_estado, -> (estado_id) {where("estado_id = ?", estado_id).order("nome")}
  belongs_to :estado
  def to_s
    nome
    "#{nome}/#{estado}"
  end
end
