# == Schema Information
#
# Table name: cargos
#
#  id         :integer          not null, primary key
#  descricao  :string
#  lideranca  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
