# == Schema Information
#
# Table name: redes
#
#  id             :integer          not null, primary key
#  descricao      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#  igreja_id      :integer
#

require 'test_helper'

class RedesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
