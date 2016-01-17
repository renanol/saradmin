class AddColumnsTituloEleitorToPessoas < ActiveRecord::Migration
  def change
    add_column :pessoas, :titulo_eleitor_numero_inscricao, :string
    add_column :pessoas, :titulo_eleitor_zona, :string
    add_column :pessoas, :titulo_eleitor_secao, :string
    add_column :pessoas, :titulo_eleitor_data_emissao, :date
  end
end
