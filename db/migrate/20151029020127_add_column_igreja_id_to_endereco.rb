class AddColumnIgrejaIdToEndereco < ActiveRecord::Migration
  def change
    add_column :enderecos, :igreja_id, :integer
    add_index :enderecos, :igreja_id
  end
end
