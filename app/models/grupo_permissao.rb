# == Schema Information
#
# Table name: grupo_permissoes
#
#  id           :integer          not null, primary key
#  valor        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  grupo_id     :integer
#  permissao_id :integer
#

class GrupoPermissao < ActiveRecord::Base

  belongs_to :grupo
  belongs_to :permissao

  accepts_nested_attributes_for :permissao
  accepts_nested_attributes_for :grupo

  enum valor: [:nenhuma, :visualizar, :alterar, :sim, :nao]

  # valor setter
  def valor=(valor)
    if not valor.kind_of? Fixnum
      valor = valor.to_i
    end
    super
  end
end
