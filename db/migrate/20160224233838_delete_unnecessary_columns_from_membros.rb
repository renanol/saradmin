class DeleteUnnecessaryColumnsFromMembros < ActiveRecord::Migration
  def change
    remove_column :membros, :titulo_eleitor_numero_inscricao, :string
    remove_column :membros, :titulo_eleitor_zona, :string
    remove_column :membros, :titulo_eleitor_secao, :string
    remove_column :membros, :titulo_eleitor_data_emissao, :date
  end
end
