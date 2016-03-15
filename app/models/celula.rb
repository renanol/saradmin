# == Schema Information
#
# Table name: celulas
#
#  id             :integer          not null, primary key
#  descricao      :string
#  sub_equipe_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#

class Celula < ActiveRecord::Base

  belongs_to :sub_equipe
  belongs_to :responsavel, class_name: "Membro", foreign_key: "responsavel_id"

  has_many :celula_membros
  has_many :membros, through: :celula_membros

  def igreja_id
    self.sub_equipe.equipe.rede.igreja.id
  end

  def membros_ids
    ids = []

    celulas = CelulaMembro.where(celula_id: self.id)

    if celulas.length > 0
      celulas.each do |c|
        ids << c.membro.id
      end
    else
      ids << -1
    end

    return ids
  end

end
