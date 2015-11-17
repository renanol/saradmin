class CreateEquipes < ActiveRecord::Migration
  def change
    create_table :equipes do |t|
      t.string :descricao
      t.references :rede, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
