class CreatePais < ActiveRecord::Migration
  def change
    create_table :pais do |t|
      t.string :nome
      t.string :sigla

      t.timestamps null: false
    end
  end
end
