class CreateTipoContribuicoes < ActiveRecord::Migration
  def change
    create_table :tipo_contribuicoes do |t|
      t.string :descricao

      t.timestamps null: false
    end
  end
end
