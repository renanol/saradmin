class Membro < ActiveRecord::Base

  belongs_to :pessoa
  belongs_to :igreja
  belongs_to :cargo

  has_many :contribuicaos

  has_many :redes, :foreign_key => 'responsavel_id'

  accepts_nested_attributes_for :pessoa
  accepts_nested_attributes_for :contribuicaos

  def to_s
    pessoa
  end


end
