class Estado < ActiveRecord::Base
  belongs_to :pais
  has_many :cidades

  def to_s
    sigla
  end
end
