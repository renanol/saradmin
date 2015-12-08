class Membro < ActiveRecord::Base

  belongs_to :pessoa
  belongs_to :igreja

end
