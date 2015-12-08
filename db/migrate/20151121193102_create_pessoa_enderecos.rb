class CreatePessoaEnderecos < ActiveRecord::Migration
  def change
    create_table :pessoa_enderecos do |t|
      t.integer :pessoa_id
      t.integer :endereco_id

      t.timestamps null: false
    end
  end
end
