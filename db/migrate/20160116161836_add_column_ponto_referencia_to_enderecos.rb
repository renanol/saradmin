class AddColumnPontoReferenciaToEnderecos < ActiveRecord::Migration
  def change
    add_column :enderecos, :ponto_referencia, :string
  end
end
