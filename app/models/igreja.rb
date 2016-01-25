class Igreja < ActiveRecord::Base
  has_many :igreja_enderecos
  has_many :enderecos, through: :igreja_enderecos

  has_many :igreja_contatos
  has_many :contatos, through: :igreja_contatos

  has_many :user_igrejas
  has_many :users, through: :user_igrejas

  belongs_to :responsavel, class_name: "Membro", foreign_key: "responsavel_id"

  accepts_nested_attributes_for :igreja_enderecos
  accepts_nested_attributes_for :contatos

  validates :descricao, presence: true
  validates :responsavel_id, presence: true

  def to_s
    descricao
  end



end
