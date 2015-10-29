class AddColumnBairroIdToEndereco < ActiveRecord::Migration
  def change
    add_column :enderecos, :bairro_id, :integer
    add_index :enderecos, :bairro_id
  end
end
