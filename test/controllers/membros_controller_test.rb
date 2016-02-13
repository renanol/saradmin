# == Schema Information
#
# Table name: membros
#
#  id                              :integer          not null, primary key
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  pessoa_id                       :integer
#  igreja_id                       :integer
#  cargo_id                        :integer
#  numero_cadastro                 :integer
#  titulo_eleitor_numero_inscricao :string
#  titulo_eleitor_zona             :string
#  titulo_eleitor_secao            :string
#  titulo_eleitor_data_emissao     :date
#  user_id                         :integer
#

require 'test_helper'

class MembrosControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
