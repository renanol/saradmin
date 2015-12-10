class Membro < ActiveRecord::Base

  belongs_to :pessoa
  belongs_to :igreja
  belongs_to :cargo

  accepts_nested_attributes_for :pessoa

end
