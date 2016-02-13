# == Schema Information
#
# Table name: celulas
#
#  id             :integer          not null, primary key
#  descricao      :string
#  sub_equipe_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#

require 'test_helper'

class CelulasControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
