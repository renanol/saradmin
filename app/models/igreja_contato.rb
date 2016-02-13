# == Schema Information
#
# Table name: igreja_contatos
#
#  id         :integer          not null, primary key
#  contato_id :integer
#  igreja_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  descricao  :string
#

class IgrejaContato < ActiveRecord::Base
  belongs_to :contato
  belongs_to :igreja

  accepts_nested_attributes_for :contato

end
