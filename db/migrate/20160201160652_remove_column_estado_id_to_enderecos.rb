class RemoveColumnEstadoIdToEnderecos < ActiveRecord::Migration
  def change
    remove_column :enderecos, :estado_id, :integer
  end
end
