class CreateCargos < ActiveRecord::Migration
  def change
    create_table :cargos do |t|
      t.string :descricao
      t.boolean :lideranca

      t.timestamps null: false
    end
  end
end
