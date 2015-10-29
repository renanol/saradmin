class AddColumnCidadeIdToEndereco < ActiveRecord::Migration
  def change
    add_column :enderecos, :cidade_id, :integer
    add_index :enderecos, :cidade_id
  end
end
