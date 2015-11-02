class CreateContatos < ActiveRecord::Migration
  def change
    create_table :contatos do |t|
      t.string :descricao
      t.integer :tipo

      t.timestamps null: false
    end
  end
end
