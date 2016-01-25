class Celula < ActiveRecord::Base
  belongs_to :sub_equipe

  belongs_to :responsavel, class_name: "Membro", foreign_key: "responsavel_id"

  

end
