# == Schema Information
#
# Table name: contribuicoes
#
#  id                   :integer          not null, primary key
#  valor                :decimal(10, 2)
#  tipo_contribuicao_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  membro_id            :integer
#  data                 :date
#

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

  def set_default_attr
    self.data ||= Time.new.to_date
  end

end
