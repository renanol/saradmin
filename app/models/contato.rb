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
