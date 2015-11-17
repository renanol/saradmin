class CreateSubEquipes < ActiveRecord::Migration
  def change
    create_table :sub_equipes do |t|
      t.string :descricao
      t.references :equipe, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
