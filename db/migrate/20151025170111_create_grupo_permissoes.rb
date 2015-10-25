class CreateGrupoPermissoes < ActiveRecord::Migration
  def change
    create_table :grupo_permissoes do |t|
      t.string :valor

      t.timestamps null: false
    end
  end
end
