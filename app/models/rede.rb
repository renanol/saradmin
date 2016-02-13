# == Schema Information
#
# Table name: redes
#
#  id             :integer          not null, primary key
#  descricao      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#  igreja_id      :integer
#

class Rede < ActiveRecord::Base

  belongs_to :responsavel, class_name: "Membro", foreign_key: "responsavel_id"
  belongs_to :igreja

  validates :descricao, presence:true
  validates :responsavel_id, presence:true


  def to_s
    descricao
  end
end
