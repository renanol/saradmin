class Estado < ActiveRecord::Base

  scope :by_pais , -> (pais_id) { where("pais_id = ?", pais_id ).order("nome") }

  belongs_to :pais
  has_many :cidades

  def to_s
    sigla
  end
end
