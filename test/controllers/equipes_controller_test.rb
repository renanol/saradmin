# == Schema Information
#
# Table name: equipes
#
#  id             :integer          not null, primary key
#  descricao      :string
#  rede_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#

require 'test_helper'

class EquipesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
