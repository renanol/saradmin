class CreateIgrejaEnderecos < ActiveRecord::Migration
  def change
    create_table :igreja_enderecos do |t|
      t.integer :igreja_id
      t.integer :endereco_id
      t.string :descricao

      t.timestamps null: false
    end
  end
end
