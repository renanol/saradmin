class Cargo < ActiveRecord::Base

  validates :descricao, presence: true

  def lidera
    if lideranca
      'SIM'
    else
      'NAO'
    end
  end

end
