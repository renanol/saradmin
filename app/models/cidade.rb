# == Schema Information
#
# Table name: cidades
#
#  id         :integer          not null, primary key
#  nome       :string
#  estado_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cidade < ActiveRecord::Base

  scope :by_estado, -> (estado_id) {where("estado_id = ?", estado_id).order("nome")}
  belongs_to :estado
  has_many :bairros

  validates :nome, uniqueness: {scope: :estado_id}

  def to_s
    nome
    "#{nome}/#{estado}"
  end
end
