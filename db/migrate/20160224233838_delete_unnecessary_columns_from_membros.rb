class DeleteUnnecessaryColumnsFromMembros < ActiveRecord::Migration
  def change
    remove_column :membros, :titulo_eleitor_numero_inscricao, :string if Membro.column_names.include?('titulo_eleitor_numero_inscricao')
    remove_column :membros, :titulo_eleitor_zona, :string if Membro.column_names.include?('titulo_eleitor_zona')
    remove_column :membros, :titulo_eleitor_secao, :string if Membro.column_names.include?('titulo_eleitor_secao')
    remove_column :membros, :titulo_eleitor_data_emissao, :date if Membro.column_names.include?('titulo_eleitor_data_emissao')
  end
end
