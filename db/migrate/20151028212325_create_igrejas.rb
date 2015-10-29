class CreateIgrejas < ActiveRecord::Migration
  def change
    create_table :igrejas do |t|
      t.string :descricao

      t.timestamps null: false
    end
  end
end
