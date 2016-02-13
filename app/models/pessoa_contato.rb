# == Schema Information
#
# Table name: pessoa_contatos
#
#  id         :integer          not null, primary key
#  pessoa_id  :integer
#  contato_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PessoaContato < ActiveRecord::Base

  belongs_to :pessoa
  belongs_to :contato

end
