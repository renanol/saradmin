class CreateCelulaMembros < ActiveRecord::Migration
  def change
    create_table :celula_membros do |t|
      t.references :celula, index: true, foreign_key: true
      t.references :membro, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
