class CreateEnderecos < ActiveRecord::Migration
  def change
    create_table :enderecos do |t|
      t.string :logradouro
      t.string :numero
      t.string :complemento
      t.string :cep

      t.timestamps null: false
    end
  end
end
