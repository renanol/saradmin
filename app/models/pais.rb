# == Schema Information
#
# Table name: pais
#
#  id         :integer          not null, primary key
#  nome       :string
#  sigla      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pais < ActiveRecord::Base
end
