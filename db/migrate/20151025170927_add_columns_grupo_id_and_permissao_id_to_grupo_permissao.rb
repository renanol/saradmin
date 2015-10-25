class AddColumnsGrupoIdAndPermissaoIdToGrupoPermissao < ActiveRecord::Migration
  def change
    add_column :grupo_permissoes, :grupo_id, :integer
    add_column :grupo_permissoes, :permissao_id, :integer
  end
end
