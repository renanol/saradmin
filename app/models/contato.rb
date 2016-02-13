# == Schema Information
#
# Table name: contatos
#
#  id         :integer          not null, primary key
#  descricao  :string
#  tipo       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contato < ActiveRecord::Base
  has_one :igreja_contato
  enum tipo: [:telefone, :email, :telefone_comercial]

  def tipo_s
    if self.telefone?
      'Telefone'
    elsif self.email?
      'E-mail'
    end
  end

end
