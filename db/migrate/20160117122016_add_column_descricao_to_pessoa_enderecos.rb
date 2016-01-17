class AddColumnDescricaoToPessoaEnderecos < ActiveRecord::Migration
  def change
    add_column :pessoa_enderecos, :descricao, :string

    PessoaEndereco.all.each do |pe|
      pe.update(descricao: 'Principal')
    end
  end
end
