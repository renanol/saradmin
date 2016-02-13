# == Schema Information
#
# Table name: sub_equipes
#
#  id             :integer          not null, primary key
#  descricao      :string
#  equipe_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#

class SubEquipe < ActiveRecord::Base

  belongs_to :responsavel, class_name: "Membro", foreign_key: "responsavel_id"

  belongs_to :equipe

  validates :descricao, presence: true
  validates :responsavel_id, presence: true

  def to_s
    descricao
  end
end
