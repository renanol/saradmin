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

  

end
