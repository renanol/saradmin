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

module ContribuicoesHelper
end
