class RemoveColumnCidadeIdToEnderecos < ActiveRecord::Migration
  def change
    remove_column :enderecos, :cidade_id, :integer
  end
end
