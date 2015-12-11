class CreateContribuicoes < ActiveRecord::Migration
  def change
    create_table :contribuicoes do |t|
      t.decimal :valor, precision: 10, scale: 2
      t.integer :tipo_contribuicao_id

      t.timestamps null: false
    end
  end
end
