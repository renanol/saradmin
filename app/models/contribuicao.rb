class Contribuicao < ActiveRecord::Base

  belongs_to :tipo_contribuicao
  belongs_to :membro
  after_initialize :format_value

  def format_value

      if(self.valor.instance_of? String)
        self.valor.to_number
      end
      self.valor
  end

  def valorFormatado
    self.valor.to_currency(Currency::BRL) if self.valor != nil
  end

end
