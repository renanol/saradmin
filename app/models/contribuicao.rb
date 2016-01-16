class Contribuicao < ActiveRecord::Base

  belongs_to :tipo_contribuicao
  belongs_to :membro

  def set_default_attr
    self.data ||= Time.new.to_date
  end

end
