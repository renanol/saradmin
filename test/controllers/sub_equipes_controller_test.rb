# == Schema Information
#
# Table name: sub_equipes
#
#  id             :integer          not null, primary key
#  descricao      :string
#  equipe_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#

require 'test_helper'

class SubEquipesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
