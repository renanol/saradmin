class CreatePessoas < ActiveRecord::Migration
  def change
    create_table :pessoas do |t|
      t.string :nome
      t.date :data_nascimento
      t.string :cpf
      t.string :rg
      t.string :numero_cadastro
      t.integer :estado_civil

      t.timestamps null: false
    end
  end
end
