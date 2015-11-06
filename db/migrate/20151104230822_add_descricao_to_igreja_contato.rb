class AddDescricaoToIgrejaContato < ActiveRecord::Migration
  def change
    add_column :igreja_contatos, :descricao, :string
  end
end
