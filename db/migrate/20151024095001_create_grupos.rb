class CreateGrupos < ActiveRecord::Migration
  def change
    create_table :grupos do |t|
      t.string :descricao
      t.integer :status

      t.timestamps null: false
    end
  end
end
