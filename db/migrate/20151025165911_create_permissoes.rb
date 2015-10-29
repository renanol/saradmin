class CreatePermissoes < ActiveRecord::Migration
  def change
    create_table :permissoes do |t|
      t.integer :modulo
      t.integer :tipo
      t.string :alias
      t.string :descricao

      t.timestamps null: false
    end
  end
end
