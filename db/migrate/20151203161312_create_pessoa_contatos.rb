class CreatePessoaContatos < ActiveRecord::Migration
  def change
    create_table :pessoa_contatos do |t|
      t.integer :pessoa_id
      t.integer :contato_id

      t.timestamps null: false
    end
  end
end
