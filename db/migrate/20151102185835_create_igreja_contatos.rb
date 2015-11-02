class CreateIgrejaContatos < ActiveRecord::Migration
  def change
    create_table :igreja_contatos do |t|
      t.references :contato, index: true, foreign_key: true
      t.references :igreja, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
