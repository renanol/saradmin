class CreateRedes < ActiveRecord::Migration
  def change
    create_table :redes do |t|
      t.string :descricao

      t.timestamps null: false
    end
  end
end
