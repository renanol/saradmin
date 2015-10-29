class CreateContatos < ActiveRecord::Migration
  def change
    create_table :contatos do |t|

      t.integer :tipo
      t.string :descricao
      t.belongs_to :endereco, index:true

      t.timestamps null: false
    end
  end
end
