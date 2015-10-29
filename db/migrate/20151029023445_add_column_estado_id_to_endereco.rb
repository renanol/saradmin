class AddColumnEstadoIdToEndereco < ActiveRecord::Migration
  def change
    add_column :enderecos, :estado_id, :integer
    add_index :enderecos, :estado_id
  end
end
