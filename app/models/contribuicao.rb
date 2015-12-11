class Contribuicao < ActiveRecord::Base

  belongs_to :tipo_contribuicao
  belongs_to :membro

end
