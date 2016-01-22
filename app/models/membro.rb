class Membro < ActiveRecord::Base

  belongs_to :user
  belongs_to :pessoa
  belongs_to :igreja
  belongs_to :cargo

  has_many :contribuicaos

  accepts_nested_attributes_for :pessoa
  accepts_nested_attributes_for :contribuicaos

  def to_s
    pessoa
  end


end
