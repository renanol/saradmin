class AddColumnNumeroCadastroToMembro < ActiveRecord::Migration
  def change
    add_column :membros, :numero_cadastro, :integer

    Membro.all.each do |m|
      m.update(numero_cadastro: m.pessoa.numero_cadastro)
    end

    remove_column :pessoas, :numero_cadastro
  end
end
