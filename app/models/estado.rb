# == Schema Information
#
# Table name: estados
#
#  id         :integer          not null, primary key
#  nome       :string
#  sigla      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pais_id    :integer
#

class Estado < ActiveRecord::Base

  scope :by_pais , -> (pais_id) { where("pais_id = ?", pais_id ).order("nome") }

  belongs_to :pais
  has_many :cidades

  validates :nome, uniqueness: {scope: :pais_id}

  def to_s
    sigla
  end
end
