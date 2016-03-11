class CelulaMembro < ActiveRecord::Base
  belongs_to :celula
  belongs_to :membro
end
