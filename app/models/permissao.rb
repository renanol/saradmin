# == Schema Information
#
# Table name: permissoes
#
#  id         :integer          not null, primary key
#  modulo     :integer
#  tipo       :integer
#  alias      :string
#  descricao  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Permissao < ActiveRecord::Base

  has_many :grupo_permissaos
  has_many :grupos, through: :grupo_permissaos

  enum tipo: [:acesso, :sim_nao]
  enum modulo: [:configuracao]

end
