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

  scope :by_membro_order, -> (membro_id) {
    where("membro_id =  ? ", membro_id).order(data: :desc)
  }

  belongs_to :tipo_contribuicao
  belongs_to :membro

  def valor=(val)
    write_attribute :valor, val.to_number
  end

  def valorFormatado
    self.valor.to_currency(Currency::BRL) if self.valor != nil
  end

  def set_default_attr
    self.data ||= Time.new.to_date
  end

end
